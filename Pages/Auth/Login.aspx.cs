using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup.Pages.Auth
{
    public partial class Login : System.Web.UI.Page
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

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["MainDB"].ConnectionString;

            if (!string.IsNullOrWhiteSpace(txtUsername.Text) && !string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand("SELECT UserID, UserType FROM Users WHERE UserID = @IdInput AND Password = @PasswordInput", conn);
                    cmd.Parameters.AddWithValue("@IdInput", txtUsername.Text);
                    cmd.Parameters.AddWithValue("@PasswordInput", txtPassword.Text);

                    try
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            Session["User"] = reader["UserID"];
                            Session["Role"] = reader["UserType"].ToString();
                        }
                        else
                        {
                            lblLoginMessage.Visible = true;
                        }
                    }
                    catch (Exception ex)
                    {
                        lblLoginMessage.Text = ex.Message;
                        lblLoginMessage.Visible = true;
                    }

                    if (Session["Role"] != null)
                    {
                        if (Session["Role"].ToString() == "User")
                        {
                            Response.Redirect("~/Pages/Users/UserDashboard.aspx");
                        }
                        else if (Session["Role"].ToString() == "Admin")
                        {
                            Response.Redirect("~/Pages/Admin/AdminPanel.aspx");
                        }
                    }
                }
            }
            else
            {
                lblLoginMessage.Visible = true;
            }

            txtUsername.Text = "";
            txtPassword.Text = "";
        }
    }
}