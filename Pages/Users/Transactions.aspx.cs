using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace GROUP01_MP_Mockup.Pages.Users
{
    public partial class Transactions : Page
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
                LoadPage(userID);
            }
        }

        private void LoadPage(int userID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                LoadTransactions(conn, userID);
                LoadBillSummary(conn, userID);
            }
        }

        private void LoadTransactions(SqlConnection conn, int userID)
        {
            string query = "SELECT t.TransactionID, t.BillID, t.AmountPaid, t.PaymentMethod, t.PaymentDate, b.DueDate FROM Transactions t LEFT JOIN Bills b ON t.BillID = b.BillID WHERE t.UserID = @uid ORDER BY t.PaymentDate DESC";

            var rows = new List<object>();
            int totalTxn = 0;
            decimal totalPaid = 0;
            int cardCount = 0;
            int cashCount = 0;
            decimal cardAmt = 0;
            decimal cashAmt = 0;

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@uid", userID);
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        string method = r["PaymentMethod"].ToString();
                        decimal amt = Convert.ToDecimal(r["AmountPaid"]);
                        DateTime pd = Convert.ToDateTime(r["PaymentDate"]);
                        string period = r["DueDate"] != DBNull.Value
                                            ? Convert.ToDateTime(r["DueDate"]).ToString("MMMM yyyy")
                                            : "—";

                        string methodClass = method == "Cash" ? "method-cash" : "method-card";

                        rows.Add(new
                        {
                            TransactionID = r["TransactionID"].ToString(),
                            BillID = r["BillID"].ToString(),
                            BillPeriod = period,
                            AmountPaid = amt.ToString("N2"),
                            PaymentMethod = method,
                            MethodClass = methodClass,
                            PaymentDate = pd.ToString("MMM dd, yyyy  h:mm tt")
                        });

                        totalTxn++;
                        totalPaid += amt;
                        if (method == "Card") { cardCount++; cardAmt += amt; }
                        else { cashCount++; cashAmt += amt; }
                    }
                }
            }

            lblTotalTxn.Text = totalTxn.ToString();
            lblTotalPaid.Text = "₱" + totalPaid.ToString("N2");
            lblCardCount.Text = cardCount.ToString();
            lblCardAmt.Text = "₱" + cardAmt.ToString("N2");
            lblCashCount.Text = cashCount.ToString();
            lblCashAmt.Text = "₱" + cashAmt.ToString("N2");
            lblCardBreakAmt.Text = "₱" + cardAmt.ToString("N2");
            lblCardBreakCount.Text = cardCount + " transaction(s)";
            lblCashBreakAmt.Text = "₱" + cashAmt.ToString("N2");
            lblCashBreakCount.Text = cashCount + " transaction(s)";
            hdnMethodData.Value = "[" + cardCount + "," + cashCount + "]";
            lblTxnCount.Text = totalTxn + (totalTxn == 1 ? " record" : " records");

            if (rows.Count > 0)
            {
                rptTxn.DataSource = rows;
                rptTxn.DataBind();
            }
            else
            {
                pnlNoTxn.Visible = true;
            }
        }

        private void LoadBillSummary(SqlConnection conn, int userID)
        {
            string query = @"SELECT t.BillID, SUM(t.AmountPaid) AS TotalPaid, COUNT(*) AS TxnCount, MAX(b.DueDate) AS DueDate FROM Transactions t LEFT JOIN Bills b ON t.BillID = b.BillID WHERE  t.UserID = @uid GROUP BY t.BillID ORDER BY MAX(t.PaymentDate) DESC";

            var rows = new List<object>();

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@uid", userID);
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        string period = r["DueDate"] != DBNull.Value
                                            ? Convert.ToDateTime(r["DueDate"]).ToString("MMMM yyyy")
                                            : "—";
                        rows.Add(new
                        {
                            BillID = r["BillID"].ToString(),
                            TotalPaid = Convert.ToDecimal(r["TotalPaid"]).ToString("N2"),
                            TxnCount = r["TxnCount"].ToString(),
                            BillPeriod = period
                        });
                    }
                }
            }

            if (rows.Count > 0)
            {
                rptBillSummary.DataSource = rows;
                rptBillSummary.DataBind();
            }
            else
            {
                pnlNoBillSummary.Visible = true;
            }
        }
    }
}