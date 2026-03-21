using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace GROUP01_MP_Mockup.Pages.Users
{
    public partial class ProcessTransaction : Page
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
                string billIDStr = Request.QueryString["billID"];
                int billID;
                if (string.IsNullOrWhiteSpace(billIDStr) || !int.TryParse(billIDStr, out billID))
                {
                    Response.Redirect("~/Pages/Users/Bills.aspx");
                    return;
                }

                hdnBillID.Value = billID.ToString();
                LoadBillInfo(billID);
                LoadCardInfo();
            }
        }

        private void LoadBillInfo(int billID)
        {
            int userID = Convert.ToInt32(Session["User"]);
            string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT AmountDue, DueDate, Status FROM Bills WHERE BillID = @bid AND UserID = @uid";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@bid", billID);
                    cmd.Parameters.AddWithValue("@uid", userID);

                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            Response.Redirect("~/Pages/Users/Bills.aspx");
                            return;
                        }

                        string status = r["Status"].ToString();
                        decimal amt = Convert.ToDecimal(r["AmountDue"]);
                        DateTime due = Convert.ToDateTime(r["DueDate"]);

                        if (status == "Paid")
                        {
                            pnlPayForm.Visible = false;
                            pnlError.Visible = true;
                            lblError.Text = "This invoice has already been paid.";
                            return;
                        }

                        string badge = status == "Partially Paid" ? "badge-partial" : "badge-unpaid";

                        lblBillID.Text = billID.ToString();
                        lblPeriod.Text = due.ToString("MMMM yyyy");
                        lblDueDate.Text = due.ToString("MMMM dd, yyyy");
                        lblStatus.Text = status;
                        litBadgeClass.Text = badge;
                        lblAmountDue.Text = amt.ToString("N2");
                    }
                }
            }
        }

        private void LoadCardInfo()
        {
            int userID = Convert.ToInt32(Session["User"]);
            string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT TOP 1 CardNumber, ExpirationMonth, ExpirationYear, BankName FROM UserCardInfo WHERE UserID = @uid";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@uid", userID);
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            hdnCardJson.Value = string.Format(
                                "{{\"number\":\"{0}\",\"bank\":\"{1}\",\"expMonth\":\"{2}\",\"expYear\":\"{3}\"}}",
                                r["CardNumber"].ToString(),
                                r["BankName"].ToString().Replace("\"", "\\\""),
                                r["ExpirationMonth"].ToString(),
                                r["ExpirationYear"].ToString()
                            );
                        }
                    }
                }
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            if (Session["User"] == null) return;

            int userID = Convert.ToInt32(Session["User"]);

            int billID;
            if (!int.TryParse(hdnBillID.Value, out billID)) return;

            string method = hdnMethod.Value;
            if (method != "Card" && method != "Cash") method = "Cash";

            string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                decimal amountDue = 0;
                string status = "";
                DateTime dueDate = DateTime.Now;

                string selectQuery = "SELECT AmountDue, DueDate, Status FROM Bills WHERE BillID = @bid AND UserID = @uid";
                using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@bid", billID);
                    cmd.Parameters.AddWithValue("@uid", userID);
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (!r.Read())
                        {
                            ShowError("Invoice not found.");
                            return;
                        }
                        amountDue = Convert.ToDecimal(r["AmountDue"]);
                        dueDate = Convert.ToDateTime(r["DueDate"]);
                        status = r["Status"].ToString();
                    }
                }

                if (status == "Paid")
                {
                    ShowError("This invoice has already been paid.");
                    return;
                }

                int newTxnID = 0;
                string insertQuery = "INSERT INTO Transactions (BillID, UserID, AmountPaid, PaymentMethod, PaymentDate) OUTPUT INSERTED.TransactionID VALUES (@bid, @uid, @amt, @method, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@bid", billID);
                    cmd.Parameters.AddWithValue("@uid", userID);
                    cmd.Parameters.AddWithValue("@amt", amountDue);
                    cmd.Parameters.AddWithValue("@method", method);
                    newTxnID = (int)cmd.ExecuteScalar();
                }

                string updateQuery = "UPDATE Bills SET Status = 'Paid' WHERE BillID = @bid";
                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@bid", billID);
                    cmd.ExecuteNonQuery();
                }

                ShowReceipt(newTxnID, billID, dueDate, amountDue, method);
            }
        }

        private void ShowReceipt(int txnID, int billID, DateTime dueDate, decimal amount, string method)
        {
            pnlPayForm.Visible = false;
            pnlReceipt.Visible = true;

            lblTxnID.Text = txnID.ToString("D6");
            lblRcptBillID.Text = billID.ToString();
            lblRcptPeriod.Text = dueDate.ToString("MMMM yyyy");
            lblRcptMethod.Text = method;
            lblRcptDate.Text = DateTime.Now.ToString("MMMM dd, yyyy  h:mm tt");
            lblRcptAmount.Text = amount.ToString("N2");
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            lblError.Text = message;
        }
    }
}