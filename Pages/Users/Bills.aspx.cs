using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup.Pages.Users
{
    public partial class Bills : System.Web.UI.Page
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
                LoadBills(conn, userID);
                LoadTransactions(conn, userID);
            }
        }

        private void LoadBills(SqlConnection conn, int userID)
        {
            string query = "SELECT BillID, AmountDue, DueDate, Status FROM Bills WHERE UserID = @uid ORDER BY DueDate DESC";

            var rows = new List<object>();
            var billDataJs = new System.Text.StringBuilder("{");

            int totalBills = 0;
            decimal outstanding = 0;
            decimal totalPaid = 0;
            DateTime? nextDue = null;
            decimal nextDueAmt = 0;

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@uid", userID);
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        int billID = Convert.ToInt32(r["BillID"]);
                        decimal amt = Convert.ToDecimal(r["AmountDue"]);
                        DateTime due = Convert.ToDateTime(r["DueDate"]);
                        string status = r["Status"].ToString();

                        string badge = status == "Paid" ? "badge-paid"
                                     : status == "Partially Paid" ? "badge-partial"
                                     : "badge-unpaid";

                        string period = due.ToString("MMMM yyyy");

                        rows.Add(new
                        {
                            BillID = billID,
                            MonthLabel = period,
                            DueDateStr = due.ToString("MMM dd, yyyy"),
                            AmountDue = amt.ToString("N2"),
                            Status = status,
                            BadgeClass = badge
                        });

                        if (billDataJs.Length > 1) billDataJs.Append(",");
                        billDataJs.AppendFormat(
                            "\"{0}\":{{\"period\":\"{1}\",\"dueDate\":\"{2}\",\"amount\":\"{3}\",\"status\":\"{4}\",\"badgeClass\":\"{5}\"}}",
                            billID,
                            period,
                            due.ToString("MMM dd, yyyy"),
                            amt.ToString("N2"),
                            status,
                            badge);

                        totalBills++;
                        if (status == "Paid")
                            totalPaid += amt;
                        else
                            outstanding += amt;
                        if (status != "Paid" && (nextDue == null || due < nextDue))
                        {
                            nextDue = due;
                            nextDueAmt = amt;
                        }
                    }
                }
            }

            billDataJs.Append("}");
            hdnBillData.Value = billDataJs.ToString();

            lblTotalBills.Text = totalBills.ToString();
            lblOutstanding.Text = "₱" + outstanding.ToString("N2");
            lblTotalPaid.Text = "₱" + totalPaid.ToString("N2");
            lblNextDue.Text = nextDue.HasValue ? nextDue.Value.ToString("MMM dd, yyyy") : "None";
            lblNextDueAmt.Text = nextDue.HasValue ? "₱" + nextDueAmt.ToString("N2") + " due" : "all clear";
            lblBillCount.Text = totalBills + (totalBills == 1 ? " record" : " records");

            if (rows.Count > 0)
            {
                rptBills.DataSource = rows;
                rptBills.DataBind();
            }
            else
            {
                pnlNoBills.Visible = true;
            }
        }

        protected void rptBills_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem) return;

            dynamic item = e.Item.DataItem;
            var pnlPay = (Panel)e.Item.FindControl("pnlPayBtn");
            if (pnlPay != null)
                pnlPay.Visible = item.Status != "Paid";
        }

        private void LoadTransactions(SqlConnection conn, int userID)
        {
            string query = "SELECT TransactionID, BillID, AmountPaid, PaymentMethod, PaymentDate FROM Transactions WHERE UserID = @uid ORDER BY PaymentDate DESC";

            var rows = new List<object>();

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@uid", userID);
                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        string method = r["PaymentMethod"].ToString();
                        string methodClass = method == "Cash" ? "cash" : "";
                        DateTime pd = Convert.ToDateTime(r["PaymentDate"]);

                        rows.Add(new
                        {
                            BillID = r["BillID"].ToString(),
                            AmountPaid = Convert.ToDecimal(r["AmountPaid"]).ToString("N2"),
                            PaymentMethod = method,
                            MethodClass = methodClass,
                            PaymentDate = pd.ToString("MMM dd, yyyy")
                        });
                    }
                }
            }

            lblTxnCount.Text = rows.Count + (rows.Count == 1 ? " record" : " records");

            if (rows.Count > 0)
            {
                rptTransactions.DataSource = rows;
                rptTransactions.DataBind();
            }
            else
            {
                pnlNoTxn.Visible = true;
            }
        }
    }
}