using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace GROUP01_MP_Mockup.Pages.Landing
{
    public partial class Default : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadProjects();
        }

        private void LoadProjects()
        {
            var sb = new StringBuilder();
            sb.Append("window.ongoingProjects=[");

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(
                "SELECT Title, Description FROM Projects WHERE Status='Ongoing' ORDER BY DateAdded DESC", conn))
            {
                conn.Open();
                var r = cmd.ExecuteReader();
                while (r.Read())
                {
                    string title = r["Title"].ToString().Replace("'", "\\'");
                    string desc = r["Description"].ToString().Replace("'", "\\'");
                    sb.Append($"{{title:'{title}',desc:'{desc}'}},");
                }
            }

            sb.Append("];");
            ClientScript.RegisterStartupScript(GetType(), "projects", sb.ToString(), true);
        }
    }
}