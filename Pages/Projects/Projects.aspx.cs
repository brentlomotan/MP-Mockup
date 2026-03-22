using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup.Pages.Projects
{
    public partial class Projects : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjects();
            }

            if (Session["Role"]?.ToString() == "Admin")
                hdnIsAdmin.Value = "1";
        }
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;
        private void LoadProjects()
        {
            var projects = new List<object>();
            int total = 0, ongoing = 0, completed = 0;
            double totalProgress = 0;

            string query = "SELECT ProjectID, Title, Description, Category, Progress, Status, DateAdded, StartDate, ExpectedDate FROM Projects ORDER BY DateAdded DESC";

            using (SqlConnection conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        total++;
                        string status = r["Status"].ToString();
                        int progress = Convert.ToInt32(r["Progress"]);
                        totalProgress += progress;

                        if (status == "Ongoing") ongoing++;
                        if (status == "Completed") completed++;

                        projects.Add(new
                        {
                            ProjectID = r["ProjectID"].ToString(),
                            Title = r["Title"].ToString(),
                            Description = r["Description"].ToString(),
                            Category = r["Category"].ToString(),
                            Progress = progress,
                            Status = status,
                            DateAdded = Convert.ToDateTime(r["DateAdded"]).ToString("MMM dd, yyyy"),
                            StartDate = r["StartDate"] != DBNull.Value ? Convert.ToDateTime(r["StartDate"]).ToString("MMM dd, yyyy") : "TBA",
                            ExpectedDate = r["ExpectedDate"] != DBNull.Value ? Convert.ToDateTime(r["ExpectedDate"]).ToString("MMM dd, yyyy") : "TBA"
                        });
                    }
                }
            }

            lblTotal.Text = total.ToString();
            lblOngoing.Text = ongoing.ToString();
            lblCompleted.Text = completed.ToString();
            lblAvgProgress.Text = total > 0 ? Math.Round(totalProgress / total) + "%" : "0%";

            var serializer = new JavaScriptSerializer();
            hdnProjectsData.Value = serializer.Serialize(projects);
        }

        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            if (Session["Role"]?.ToString() != "Admin") return;

            string title = txtTitle.Text.Trim();
            string desc = txtDescription.Text.Trim();
            int category, progress;
            string status = ddlStatus.SelectedValue;
            int adminID = Convert.ToInt32(Session["User"]);
            int editID = Convert.ToInt32(hdnEditID.Value);

            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(desc))
            {
                lblFormMsg.Text = "Please fill in all fields.";
                hdnFormOpen.Value = "1";
                LoadProjects();
                return;
            }

            if (!int.TryParse(txtProgress.Text, out progress) || progress < 0 || progress > 100)
            {
                lblFormMsg.Text = "Progress must be a number between 0 and 100.";
                hdnFormOpen.Value = "1";
                LoadProjects();
                return;
            }

            category = Convert.ToInt32(ddlCategory.SelectedValue);

            using (SqlConnection conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                if (editID == 0)
                {
                    //ADD
                    string query = @"INSERT INTO Projects (UserID, Title, Description, Category, Progress, Status, DateAdded, StartDate, ExpectedDate)
                                     VALUES (@UID, @Title, @Desc, @Cat, @Progress, @Status, @Date, @StartDate, @ExpectedDate)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UID", adminID);
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Desc", desc);
                        cmd.Parameters.AddWithValue("@Cat", category);
                        cmd.Parameters.AddWithValue("@Progress", progress);
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@Date", DateTime.Today);
                        cmd.Parameters.AddWithValue("@StartDate", string.IsNullOrWhiteSpace(txtStartDate.Text) ? (object)DBNull.Value : txtStartDate.Text);
                        cmd.Parameters.AddWithValue("@ExpectedDate", string.IsNullOrWhiteSpace(txtExpectedDate.Text) ? (object)DBNull.Value : txtExpectedDate.Text);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    //EDIT
                    string query = @"UPDATE Projects SET Title=@Title, Description=@Desc,
                    Category=@Cat, Progress=@Progress, Status=@Status,
                    StartDate=@StartDate, ExpectedDate=@ExpectedDate
                    WHERE ProjectID=@ID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Desc", desc);
                        cmd.Parameters.AddWithValue("@Cat", category);
                        cmd.Parameters.AddWithValue("@Progress", progress);
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@ID", editID);
                        cmd.Parameters.AddWithValue("@StartDate", string.IsNullOrWhiteSpace(txtStartDate.Text) ? (object)DBNull.Value : txtStartDate.Text);
                        cmd.Parameters.AddWithValue("@ExpectedDate", string.IsNullOrWhiteSpace(txtExpectedDate.Text) ? (object)DBNull.Value : txtExpectedDate.Text);
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            //Reset form
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtProgress.Text = "";
            txtStartDate.Text = "";
            txtExpectedDate.Text = "";
            hdnEditID.Value = "0";
            hdnFormOpen.Value = "0";
            lblFormMsg.Text = "";

            LoadProjects();
        }

        protected void btnDeleteConfirm_Click(object sender, EventArgs e)
        {
            if (Session["Role"]?.ToString() != "Admin") return;

            int deleteID = Convert.ToInt32(hdnDeleteID.Value);
            if (deleteID == 0) return;

            using (SqlConnection conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Projects WHERE ProjectID = @ID", conn))
                {
                    cmd.Parameters.AddWithValue("@ID", deleteID);
                    cmd.ExecuteNonQuery();
                }
            }

            hdnDeleteID.Value = "0";
            LoadProjects();
        }
    }
}