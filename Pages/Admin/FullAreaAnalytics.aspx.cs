using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace GROUP01_MP_Mockup.Pages.Admin
{
    public partial class FullAreaAnalytics : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Pages/Landing/Default.aspx");
                return;
            }
            if (!IsPostBack) LoadAnalytics();
        }

        private void LoadAnalytics()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

            
                int totalUsers = Scalar(conn, "SELECT COUNT(*) FROM Users WHERE UserType='User'");
                int approvedUsers = Scalar(conn, "SELECT COUNT(*) FROM UserProfile WHERE ApprovalStatus='Approved'");
                int pendingUsers = Scalar(conn, "SELECT COUNT(*) FROM UserProfile WHERE ApprovalStatus='Pending'");
                int totalProjects = Scalar(conn, "SELECT COUNT(*) FROM Projects");
                int ongoingProj = Scalar(conn, "SELECT COUNT(*) FROM Projects WHERE Status='Ongoing'");
                int completedProj = Scalar(conn, "SELECT COUNT(*) FROM Projects WHERE Status='Completed'");
                decimal totalBilled = ScalarDecimal(conn, "SELECT ISNULL(SUM(AmountDue),0) FROM Bills");
                decimal totalCollected = ScalarDecimal(conn, "SELECT ISNULL(SUM(AmountPaid),0) FROM Transactions");
                int totalConsumption = Scalar(conn, "SELECT ISNULL(SUM(ConsumptionValue),0) FROM UsageLogs");

            
                var barangayLabels = new List<string>();
                var barangayValues = new List<int>();
                using (var cmd = new SqlCommand(@"
                    SELECT b.BarangayName, ISNULL(SUM(ul.ConsumptionValue),0) AS Total
                    FROM Barangays b
                    LEFT JOIN UserProfile up ON up.UserBarangay = b.BarangayID
                    LEFT JOIN UsageLogs ul ON ul.UserID = up.UserID
                    GROUP BY b.BarangayName
                    ORDER BY Total DESC", conn))
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        barangayLabels.Add(r["BarangayName"].ToString());
                        barangayValues.Add(Convert.ToInt32(r["Total"]));
                    }
                }

            
                int billPaid = Scalar(conn, "SELECT COUNT(*) FROM Bills WHERE Status='Paid'");
                int billUnpaid = Scalar(conn, "SELECT COUNT(*) FROM Bills WHERE Status='Not Paid'");
                int billPartial = Scalar(conn, "SELECT COUNT(*) FROM Bills WHERE Status='Partially Paid'");

              
                var catLabels = new List<string> { "Infrastructure", "Water Quality", "Maintenance", "Expansion", "Conservation", "Other" };
                var catValues = new List<int>();
                for (int i = 1; i <= 6; i++)
                    catValues.Add(Scalar(conn, $"SELECT COUNT(*) FROM Projects WHERE Category={i}"));

                var heatRows = new List<(int uid, int month, int year, int val)>();
                using (var cmd = new SqlCommand("SELECT UserID, Month, Year, ConsumptionValue FROM UsageLogs ORDER BY Year, Month", conn))
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                        heatRows.Add((Convert.ToInt32(r["UserID"]), Convert.ToInt32(r["Month"]), Convert.ToInt32(r["Year"]), Convert.ToInt32(r["ConsumptionValue"])));
                }

               
                var sb = new StringBuilder();
                sb.Append("window.analyticsData = {");
                sb.Append($"kpi:{{totalUsers:{totalUsers},approvedUsers:{approvedUsers},pendingUsers:{pendingUsers},");
                sb.Append($"totalProjects:{totalProjects},ongoingProj:{ongoingProj},completedProj:{completedProj},");
                sb.Append($"totalBilled:{totalBilled},totalCollected:{totalCollected},totalConsumption:{totalConsumption}}},");
                sb.Append($"barangayLabels:{ToJsArray(barangayLabels)},");
                sb.Append($"barangayValues:[{string.Join(",", barangayValues)}],");
                sb.Append($"billStatus:[{billPaid},{billUnpaid},{billPartial}],");
                sb.Append($"catLabels:{ToJsArray(catLabels)},");
                sb.Append($"catValues:[{string.Join(",", catValues)}],");
                sb.Append("heatmap:[");
                foreach (var h in heatRows)
                    sb.Append($"{{uid:{h.uid},month:{h.month},year:{h.year},val:{h.val}}},");
                sb.Append("]};");

                ClientScript.RegisterStartupScript(GetType(), "data", sb.ToString(), true);
            }
        }

        private int Scalar(SqlConnection conn, string sql)
        {
            using (var cmd = new SqlCommand(sql, conn))
                return Convert.ToInt32(cmd.ExecuteScalar());
        }

        private decimal ScalarDecimal(SqlConnection conn, string sql)
        {
            using (var cmd = new SqlCommand(sql, conn))
                return Convert.ToDecimal(cmd.ExecuteScalar());
        }

        private string ToJsArray(List<string> list)
        {
            var sb = new StringBuilder("[");
            foreach (var s in list) sb.Append($"'{s.Replace("'", "\\'")}',");
            sb.Append("]");
            return sb.ToString();
        }
    }
}
