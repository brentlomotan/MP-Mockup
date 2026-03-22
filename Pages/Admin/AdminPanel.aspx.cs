using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup.Pages.Admin
{
    public partial class AdminPanel : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;
        DataTable PendingUsers = new DataTable();
        void LoadPendingUsers()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(
                    "SELECT UserID, FirstName, LastName, UserBarangay, UserAddress, DateRegistered FROM UserProfile WHERE ApprovalStatus = 'Pending' ORDER BY DateRegistered ASC", con))
                {
                    con.Open();
                    adapter.Fill(PendingUsers);
                }
                PendingSet.DataSource = PendingUsers;
                PendingSet.DataBind();
            }
        }
        void LoadAnnouncements()
        {
            var rows = new List<object>();
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT AnnouncementID, UserID, Title, Description, Category FROM Announcements ORDER BY DateAdded DESC", con))
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        string desc = r["Description"].ToString();
                        string preview = desc.Length > 80 ? desc.Substring(0, 80) + "..." : desc;
                        rows.Add(new
                        {
                            AnnouncementID = r["AnnouncementID"].ToString(),
                            UserID = r["UserID"].ToString(),
                            Title = r["Title"].ToString(),
                            Category = r["Category"].ToString(),
                            PreviewDesc = preview
                        });
                    }
                }
            }
            AnnouncementsRepeater.DataSource = rows;
            AnnouncementsRepeater.DataBind();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPendingUsers();
                LoadAnnouncements();
            }
        }
        protected void Accept_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE UserProfile SET ApprovalStatus = 'Approved' WHERE UserID = @SelectedID", con))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@SelectedID", btn.CommandArgument);
                        cmd.ExecuteNonQuery();
                        litMessage.Text = "Successfully accepted user!";
                        pnlNotification.Visible = true;
                        LoadPendingUsers();
                        LoadAnnouncements();
                    }
                    catch (Exception ex)
                    {
                        litMessage.Text = ex.Message;
                        pnlNotification.Visible = true;
                    }
                }
            }
        }
        protected void Reject_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE UserProfile SET ApprovalStatus = 'Rejected' WHERE UserID = @SelectedID", con))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@SelectedID", btn.CommandArgument);
                        cmd.ExecuteNonQuery();
                        litMessage.Text = "Successfully rejected user!";
                        pnlNotification.Visible = true;
                        LoadPendingUsers();
                        LoadAnnouncements();
                    }
                    catch (Exception ex)
                    {
                        litMessage.Text = ex.Message;
                        pnlNotification.Visible = true;
                    }
                }
            }
        }
        protected void btnNotifClose_Click(object sender, EventArgs e)
        {
            pnlNotification.Visible = false;
        }
        protected void btnSaveAnn_Click(object sender, EventArgs e)
        {
            int annID = Convert.ToInt32(hdnAnnID.Value);
            int adminID = Convert.ToInt32(Session["User"]);
            string title = txtAnnTitle.Text.Trim();
            string desc = txtAnnDesc.Text.Trim();
            string category = ddlAnnCategory.SelectedValue;

            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(desc))
            {
                lblAnnMsg.Text = "Please fill in all fields.";
                hdnAnnFormOpen.Value = "1";
                LoadPendingUsers();
                LoadAnnouncements();
                return;
            }
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                if (annID == 0)
                {
                    //ADD
                    using (SqlCommand cmd = new SqlCommand(
                        "INSERT INTO Announcements (UserID, Title, Description, Category, DateAdded) VALUES (@UID, @Title, @Desc, @Cat, @Date)", con))
                    {
                        cmd.Parameters.AddWithValue("@UID", adminID);
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Desc", desc);
                        cmd.Parameters.AddWithValue("@Cat", category);
                        cmd.Parameters.AddWithValue("@Date", DateTime.Today);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    //EDIT
                    using (SqlCommand cmd = new SqlCommand(
                        "UPDATE Announcements SET Title=@Title, Description=@Desc, Category=@Cat WHERE AnnouncementID=@ID", con))
                    {
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Desc", desc);
                        cmd.Parameters.AddWithValue("@Cat", category);
                        cmd.Parameters.AddWithValue("@ID", annID);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            //Reset form
            hdnAnnID.Value = "0";
            txtAnnTitle.Text = "";
            txtAnnDesc.Text = "";
            hdnAnnFormOpen.Value = "0";
            lblAnnMsg.Text = "";

            LoadPendingUsers();
            LoadAnnouncements();
        }
        protected void EditAnn_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int annID = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT Title, Description, Category FROM Announcements WHERE AnnouncementID = @ID", con))
                {
                    cmd.Parameters.AddWithValue("@ID", annID);
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            hdnAnnID.Value = annID.ToString();
                            txtAnnTitle.Text = r["Title"].ToString();
                            txtAnnDesc.Text = r["Description"].ToString();
                            ddlAnnCategory.SelectedValue = r["Category"].ToString();
                            hdnAnnFormOpen.Value = "1";
                        }
                    }
                }
            }
            LoadPendingUsers();
            LoadAnnouncements();
        }
        protected void DeleteAnn_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(
                    "DELETE FROM Announcements WHERE AnnouncementID = @ID", con))
                {
                    cmd.Parameters.AddWithValue("@ID", btn.CommandArgument);
                    cmd.ExecuteNonQuery();
                }
            }
            litMessage.Text = "Announcement deleted.";
            pnlNotification.Visible = true;
            LoadPendingUsers();
            LoadAnnouncements();
        }
    }
}