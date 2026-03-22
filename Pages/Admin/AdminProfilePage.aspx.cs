using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace GROUP01_MP_Mockup.Pages.Admin
{
    public partial class AdminProfilePage : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Pages/Landing/Default.aspx");
                return;
            }
            if (!IsPostBack) LoadProfile();
        }

        private void LoadProfile()
        {
            int userID = Convert.ToInt32(Session["User"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("SELECT UserID, UserType FROM Users WHERE UserID = @uid", conn))
            {
                cmd.Parameters.AddWithValue("@uid", userID);
                conn.Open();
                var r = cmd.ExecuteReader();
                if (r.Read())
                {
                    string uid = r["UserID"].ToString();
                    string role = r["UserType"].ToString();
                    string js = $@"window.addEventListener('DOMContentLoaded',function(){{
                        document.getElementById('dispUID').innerText  = '{uid}';
                        document.getElementById('dispRole').innerText = '{role}';
                    }});";
                    ClientScript.RegisterStartupScript(GetType(), "Load", js, true);
                }
            }
        }

        protected void btnSaveSettings_Click(object sender, EventArgs e)
        {
            if (Session["Role"]?.ToString() != "Admin") return;
            ClientScript.RegisterStartupScript(GetType(), "Toast",
                "document.getElementById('toast').classList.add('show');setTimeout(function(){document.getElementById('toast').classList.remove('show');},3000);", true);
        }
    }
}
