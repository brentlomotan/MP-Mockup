using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;

namespace GROUP01_MP_Mockup.Pages.Users
{
    public partial class UserAnalytics : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null || Session["Role"] == null || Session["Role"].ToString() != "User")
            {
                Response.Redirect("~/Pages/Landing/Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                int userID = Convert.ToInt32(Session["User"]);
                LoadAnalytics(userID);
            }
        }

        protected void btnBackDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Users/UserDashboard.aspx");
        }

        private void LoadAnalytics(int userID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;
            double[] monthlyData = new double[12];
            int currentYear = DateTime.Now.Year;
            int twoDigitYear = currentYear % 100;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string query = @"
                    SELECT [Month], ConsumptionValue 
                    FROM UsageLogs 
                    WHERE UserID = @uid AND ([Year] = @year OR [Year] = @year2)
                    ORDER BY [Month]";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@uid", userID);
                    cmd.Parameters.AddWithValue("@year", currentYear);
                    cmd.Parameters.AddWithValue("@year2", twoDigitYear);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int month = Convert.ToInt32(reader["Month"]);
                            if (month >= 1 && month <= 12)
                                monthlyData[month - 1] += Convert.ToDouble(reader["ConsumptionValue"]);
                        }
                    }
                }
            }

            // Fill the hidden field for Chart.js
            hdnAnalyticsBarData.Value = "[" + string.Join(",", monthlyData) + "]";

            // Bind the monthly table
            var tableRows = new List<object>();
            for (int i = 0; i < 12; i++)
            {
                string monthName = CultureInfo.CurrentCulture.DateTimeFormat.GetAbbreviatedMonthName(i + 1);
                tableRows.Add(new { Month = monthName, Consumption = monthlyData[i].ToString("0.##") });
            }

            rptMonthlyTrends.DataSource = tableRows;
            rptMonthlyTrends.DataBind();
        }
    }
}