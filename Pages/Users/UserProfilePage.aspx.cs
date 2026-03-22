using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup.Pages.Users
{
    public partial class UserProfilePage : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "User")
            {
                Response.Redirect("~/Pages/Landing/Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadBarangays();
                LoadProfile();
            }
        }

        private void LoadBarangays()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("SELECT BarangayID, BarangayName FROM Barangays ORDER BY BarangayName", conn))
            {
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                ddlBarangay.Items.Clear();
                ddlBarangay.Items.Add(new ListItem("Select Barangay", ""));

                while (dr.Read())
                {
                    ddlBarangay.Items.Add(new ListItem(dr["BarangayName"].ToString(), dr["BarangayID"].ToString()));
                }
                conn.Close();
            }
        }

        private void LoadProfile()
        {
            if (Session["User"] == null) return;
            int userID = Convert.ToInt32(Session["User"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(
                @"SELECT ProfileID, UserID, FirstName, LastName, UserBarangay, UserAddress, DateRegistered
                  FROM UserProfile
                  WHERE UserID = @uid", conn))
            {
                cmd.Parameters.AddWithValue("@uid", userID);
                conn.Open();

                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        lblProfileID.Text = r["ProfileID"].ToString();
                        lblUserID.Text = r["UserID"].ToString();
                        lblDateRegistered.Text = Convert.ToDateTime(r["DateRegistered"]).ToString("MMMM dd, yyyy");

                        txtFirstName.Text = r["FirstName"].ToString();
                        txtLastName.Text = r["LastName"].ToString();
                        txtAddress.Text = r["UserAddress"].ToString();

                        string barangayID = r["UserBarangay"].ToString();
                        if (!string.IsNullOrEmpty(barangayID))
                        {
                            ddlBarangay.SelectedValue = barangayID;
                        }
                    }
                }
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            // Clear previous errors
            txtFirstName.CssClass = "finput";
            txtLastName.CssClass = "finput";
            txtAddress.CssClass = "finput";
            ddlBarangay.CssClass = "finput";

            Regex nameRegex = new Regex(@"^[a-zA-Z]+$");
            Regex addressRegex = new Regex(@"^[a-zA-Z0-9\s,.-]+$");
            bool invalid = false;

            if (!nameRegex.IsMatch(txtFirstName.Text)) { txtFirstName.CssClass += " input-error"; invalid = true; }
            if (!nameRegex.IsMatch(txtLastName.Text)) { txtLastName.CssClass += " input-error"; invalid = true; }
            if (!addressRegex.IsMatch(txtAddress.Text)) { txtAddress.CssClass += " input-error"; invalid = true; }
            if (string.IsNullOrEmpty(ddlBarangay.SelectedValue)) { ddlBarangay.CssClass += " input-error"; invalid = true; }

            if (invalid)
            {
                ClientScript.RegisterStartupScript(GetType(), "Toast", "showToast('Please correct the highlighted fields!');", true);
                return;
            }

            int userID = Convert.ToInt32(Session["User"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(
                @"UPDATE UserProfile
                  SET FirstName=@FirstName,
                      LastName=@LastName,
                      UserBarangay=@Barangay,
                      UserAddress=@Address
                  WHERE UserID=@UserID", conn))
            {
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                cmd.Parameters.AddWithValue("@Barangay", ddlBarangay.SelectedValue);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                cmd.Parameters.AddWithValue("@UserID", userID);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadProfile();
            ClientScript.RegisterStartupScript(GetType(), "Toast", "showToast('Profile updated successfully!');", true);
        }
    }
}