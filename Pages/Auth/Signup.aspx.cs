using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup.Pages.Auth
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null && Session["Role"] != null)
            {
                if (Session["Role"].ToString() == "Admin")
                    Response.Redirect("~/Pages/Admin/AdminPanel.aspx");
                else
                    Response.Redirect("~/Pages/Users/UserDashboard.aspx");
                return;
            }
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                lblSignupMessage.Text = "Passwords do not match.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string countQuery = "SELECT MAX(UserID) FROM Users";
                int lastNumber = 0;
                using (SqlCommand countCmd = new SqlCommand(countQuery, conn))
                {
                    object result = countCmd.ExecuteScalar();
                    lastNumber = (result == DBNull.Value || result == null) ? 0 : Convert.ToInt32(result);
                }

                string addQuery = "INSERT INTO Users (UserID, Password, UserType) VALUES (@ID, @Password, @Role)";
                int userID = lastNumber + 1;
                using (SqlCommand add = new SqlCommand(addQuery, conn))
                {
                    add.Parameters.AddWithValue("@ID", userID);
                    add.Parameters.AddWithValue("@Password", txtPassword.Text);
                    add.Parameters.AddWithValue("@Role", "User");
                    add.ExecuteNonQuery();
                }

                string profileQuery = @"INSERT INTO UserProfile (UserID, FirstName, LastName, UserBarangay, UserAddress, ApprovalStatus, DateRegistered) VALUES (@ID, @FirstName, @LastName, @Barangay, @Address, @Status, @Date)";
                using (SqlCommand profile = new SqlCommand(profileQuery, conn))
                {
                    profile.Parameters.AddWithValue("@ID", userID);
                    profile.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                    profile.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                    profile.Parameters.AddWithValue("@Barangay", ddlBarangay.SelectedValue);
                    profile.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                    profile.Parameters.AddWithValue("@Status", "Pending");
                    profile.Parameters.AddWithValue("@Date", DateTime.Today);
                    profile.ExecuteNonQuery();
                }

                Session["User"] = userID;
                Session["Role"] = "User";
                Response.Redirect("~/Pages/Users/UserDashboard.aspx");
            }
        }
    }
}