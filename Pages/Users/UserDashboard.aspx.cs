using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup.Pages.Users
{
    public partial class UserDashboard : System.Web.UI.Page
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
                LoadDashboard(userID);
            }
        }

        private void LoadDashboard(int userID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                LoadUserProfile(conn, userID);
                LoadUsageData(conn, userID);
                LoadBillData(conn, userID);
                LoadAnnouncements(conn);
            }
        }

        private void LoadUserProfile(SqlConnection conn, int userID)
        {
            string profileQuery = "SELECT up.FirstName, up.LastName, up.UserBarangay, up.UserAddress, up.ApprovalStatus, up.DateRegistered, b.BarangayName FROM UserProfile up LEFT JOIN Barangays b ON up.UserBarangay = b.BarangayID WHERE up.UserID = @uid";
            using (SqlCommand cmd = new SqlCommand(profileQuery, conn))
            {
                cmd.Parameters.AddWithValue("@uid", userID);
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        lblFirstName.Text = r["FirstName"].ToString() + " " + r["LastName"].ToString();
                        lblBarangayName.Text = r["BarangayName"] != DBNull.Value
                                                ? "Brgy. " + r["BarangayName"].ToString()
                                                : r["UserBarangay"].ToString();
                        lblAddress.Text = r["UserAddress"].ToString();
                        lblApprovalStatus.Text = r["ApprovalStatus"].ToString();
                        lblUserID.Text = userID.ToString();

                        if (r["DateRegistered"] != DBNull.Value)
                        {
                            DateTime reg = Convert.ToDateTime(r["DateRegistered"]);
                            lblMemberSince.Text = reg.ToString("MMMM yyyy");
                        }
                    }
                }
            }
        }

        private void LoadUsageData(SqlConnection conn, int userID)
        {
            int currentYear = DateTime.Now.Year;
            int twoDigitYear = currentYear % 100;
            double[] monthlyData = new double[12];

            string usageQuery = "SELECT [Month], ConsumptionValue FROM UsageLogs WHERE UserID = @UID AND ([Year] = @Year OR [Year] = @Year2) ORDER BY [Month]";
            using (SqlCommand cmd = new SqlCommand(usageQuery, conn))
            {
                cmd.Parameters.AddWithValue("@UID", userID);
                cmd.Parameters.AddWithValue("@Year", currentYear);
                cmd.Parameters.AddWithValue("@Year2", twoDigitYear);

                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        int month = Convert.ToInt32(r["Month"]);
                        if (month >= 1 && month <= 12)
                            monthlyData[month - 1] = Convert.ToDouble(r["ConsumptionValue"]);
                    }
                }
            }

            double latestVal = 0;
            int latestMonth = 0;
            for (int i = 11; i >= 0; i--)
            {
                if (monthlyData[i] > 0)
                {
                    latestVal = monthlyData[i];
                    latestMonth = i + 1;
                    break;
                }
            }

            if (latestMonth > 0)
            {
                string monthName = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(latestMonth);
                lblUsageValue.Text = latestVal.ToString("0");
                lblUsagePeriod.Text = "cubic meters — " + monthName + " " + currentYear;
                lblLatestUsage.Text = latestVal.ToString("0");
                lblLatestPeriod.Text = monthName + " " + currentYear;
            }
            else
            {
                lblUsageValue.Text = "—";
                lblUsagePeriod.Text = "No readings this year";
                lblLatestUsage.Text = "—";
                lblLatestPeriod.Text = "";
            }

            hdnChartData.Value = "[" + string.Join(",", monthlyData) + "]";

            var usageRows = new List<object>();
            double maxVal = 0;
            foreach (double v in monthlyData) if (v > maxVal) maxVal = v;
            if (maxVal == 0) maxVal = 1;

            for (int i = 11; i >= 0 && usageRows.Count < 3; i--)
            {
                if (monthlyData[i] > 0)
                {
                    string mn = CultureInfo.CurrentCulture.DateTimeFormat.GetAbbreviatedMonthName(i + 1);
                    int pct = (int)Math.Round(monthlyData[i] / maxVal * 100);
                    usageRows.Add(new
                    {
                        MonthLabel = mn + " " + currentYear,
                        ConsumptionValue = monthlyData[i].ToString("0"),
                        BarPct = pct
                    });
                }
            }

            if (usageRows.Count > 0)
            {
                rptUsage.DataSource = usageRows;
                rptUsage.DataBind();
            }
            else
            {
                pnlNoUsage.Visible = true;
            }
        }

        private void LoadBillData(SqlConnection conn, int userID)
        {
            int countUnpaid = 0, countPartial = 0, countPaid = 0;
            bool hasUnpaid = false;

            string billQuery = "SELECT TOP 5 BillID, AmountDue, DueDate, Status FROM Bills WHERE UserID = @uid ORDER BY DueDate DESC";

            var billRows = new List<object>();

            using (SqlCommand cmd = new SqlCommand(billQuery, conn))
            {
                cmd.Parameters.AddWithValue("@uid", userID);
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    int idx = 0;
                    while (r.Read())
                    {
                        string status = r["Status"].ToString();
                        DateTime due = Convert.ToDateTime(r["DueDate"]);
                        decimal amt = Convert.ToDecimal(r["AmountDue"]);

                        if (status == "Not Paid") { countUnpaid++; hasUnpaid = true; }
                        else if (status == "Partially Paid") countPartial++;
                        else if (status == "Paid") countPaid++;

                        string badge = status == "Paid" ? "badge-paid"
                                     : status == "Partially Paid" ? "badge-partial"
                                     : "badge-unpaid";

                        string label = due.ToString("MMMM yyyy");

                        billRows.Add(new
                        {
                            BillLabel = label,
                            DueDateStr = due.ToString("MMM dd, yyyy"),
                            AmountDue = amt.ToString("N2"),
                            Status = status,
                            BadgeClass = badge
                        });
                        idx++;
                    }
                }
            }

            if (billRows.Count > 0)
            {
                dynamic latest = billRows[0];
                lblAmountDue.Text = "₱" + latest.AmountDue;
                lblDueDate.Text = "Due " + latest.DueDateStr;
                lblBillStatus.Text = latest.Status;
                lblBillPeriod.Text = latest.BillLabel;
            }
            else
            {
                lblAmountDue.Text = "₱0.00";
                lblDueDate.Text = "No bills yet";
                lblBillStatus.Text = "—";
                lblBillPeriod.Text = "";
            }

            if (billRows.Count > 0)
            {
                rptBills.DataSource = billRows;
                rptBills.DataBind();
            }
            else
            {
                pnlNoBills.Visible = true;
            }

            pnlActionBox.Visible = hasUnpaid;

            lblCountUnpaid.Text = countUnpaid.ToString();
            lblCountPartial.Text = countPartial.ToString();
            lblCountPaid.Text = countPaid.ToString();

            hdnDonutData.Value = "[" + countUnpaid + "," + countPartial + "," + countPaid + "]";
        }

        private void LoadAnnouncements(SqlConnection conn)
        {
            string announcementQuery = "SELECT TOP 5 Title, Description, Category, DateAdded FROM Announcements ORDER BY DateAdded DESC";

            var annRows = new List<object>();

            using (SqlCommand cmd = new SqlCommand(announcementQuery, conn))
            {
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        string cat = r["Category"].ToString();
                        string catClass = cat == "Important" ? "important" : "regular";
                        DateTime da = Convert.ToDateTime(r["DateAdded"]);

                        annRows.Add(new
                        {
                            Title = r["Title"].ToString(),
                            Description = r["Description"].ToString(),
                            Category = cat,
                            CategoryClass = catClass,
                            DateStr = da.ToString("MMM dd, yyyy")
                        });
                    }
                }
            }

            if (annRows.Count > 0)
            {
                rptAnnouncements.DataSource = annRows;
                rptAnnouncements.DataBind();
            }
            else
            {
                pnlNoAnnouncements.Visible = true;
            }
        }

        protected void btnViewAnalytics_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Users/UserAnalytics.aspx");
        }
    }
}