using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup.Pages.Projects
{
    public partial class ProjectsDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string idParam = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idParam) && int.TryParse(idParam, out int projectID))
                {
                    hdnProjectID.Value = projectID.ToString();
                    LoadProject(projectID);
                }
                else
                {
                    Response.Redirect("~/Pages/Projects/Projects.aspx");
                }
            }
            if (Session["Role"]?.ToString() == "Admin")
                pnlAdminEdit.Visible = true;
        }
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;
        private void LoadProject(int projectID)
        {
            string[] catNames = { "", "Category 1", "Category 2", "Category 3", "Category 4", "Category 5", "Category 6" };
            string[] catClasses = { "", "proj-cat-1", "proj-cat-2", "proj-cat-3", "proj-cat-4", "proj-cat-5", "proj-cat-6" };

            string query = "SELECT Title, Description, Category, Progress, Status, DateAdded, StartDate, ExpectedDate FROM Projects WHERE ProjectID = @ID";

            using (SqlConnection conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", projectID);
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            string title = r["Title"].ToString();
                            string desc = r["Description"].ToString();
                            int category = Convert.ToInt32(r["Category"]);
                            int progress = Convert.ToInt32(r["Progress"]);
                            string status = r["Status"].ToString();
                            DateTime dateAdded = Convert.ToDateTime(r["DateAdded"]);

                            Page.Title = title;
                            lblTitle.Text = title;
                            lblDescription.Text = desc;
                            lblDateAdded.Text = dateAdded.ToString("MMMM dd, yyyy");
                            lblProgress.Text = progress.ToString();

                            string statusClass = status == "Ongoing" ? "proj-badge-ongoing"
                                              : status == "Completed" ? "proj-badge-completed"
                                              : "proj-badge-cancelled";

                            lblStatusBadge.Text = $"<span class='proj-badge {statusClass}'>{status}</span>";
                            lblCategoryBadge.Text = $"<span class='proj-badge {catClasses[category]}'>{catNames[category]}</span>";

                            //Set progress bar width via data attribute
                            var progressFillControl = Page.FindControl("progressFill") as System.Web.UI.HtmlControls.HtmlGenericControl;
                            if (progressFillControl != null)
                                progressFillControl.Attributes["data-width"] = progress.ToString();

                            //Pre-fill edit form
                            txtTitle.Text = title;
                            txtDescription.Text = desc;
                            txtProgress.Text = progress.ToString();
                            ddlStatus.SelectedValue = status;
                            ddlCategory.SelectedValue = category.ToString();
                            txtStartDate.Text = r["StartDate"] != DBNull.Value ? Convert.ToDateTime(r["StartDate"]).ToString("yyyy-MM-dd") : "";
                            txtExpectedDate.Text = r["ExpectedDate"] != DBNull.Value ? Convert.ToDateTime(r["ExpectedDate"]).ToString("yyyy-MM-dd") : "";
                        }
                        else
                        {
                            Response.Redirect("~/Pages/Projects/Projects.aspx");
                        }
                    }
                }
            }
        }
        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            if (Session["Role"]?.ToString() != "Admin") return;

            int projectID = Convert.ToInt32(hdnProjectID.Value);
            string title = txtTitle.Text.Trim();
            string desc = txtDescription.Text.Trim();
            string status = ddlStatus.SelectedValue;
            int category = Convert.ToInt32(ddlCategory.SelectedValue);

            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(desc))
            {
                lblFormMsg.Text = "Please fill in all fields.";
                hdnFormOpen.Value = "1";
                LoadProject(projectID);
                return;
            }
            if (!int.TryParse(txtProgress.Text, out int progress) || progress < 0 || progress > 100)
            {
                lblFormMsg.Text = "Progress must be a number between 0 and 100.";
                hdnFormOpen.Value = "1";
                LoadProject(projectID);
                return;
            }
            using (SqlConnection conn = new SqlConnection(ConnStr))
            {
                conn.Open();
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
                    cmd.Parameters.AddWithValue("@ID", projectID);
                    cmd.Parameters.AddWithValue("@StartDate", string.IsNullOrWhiteSpace(txtStartDate.Text) ? (object)DBNull.Value : txtStartDate.Text);
                    cmd.Parameters.AddWithValue("@ExpectedDate", string.IsNullOrWhiteSpace(txtExpectedDate.Text) ? (object)DBNull.Value : txtExpectedDate.Text);
                    cmd.ExecuteNonQuery();
                }
            }
            hdnFormOpen.Value = "0";
            LoadProject(projectID);
        }
    }
}