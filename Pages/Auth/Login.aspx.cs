using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup.Pages.Auth
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtUsername.Text) && !string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                //Temp till data base added
                if (txtUsername.Text == "admin" && txtPassword.Text == "admin")
                {
                    Session["User"] = txtUsername.Text;
                    Session["Role"] = "Admin";
                }
                else
                {
                    Session["User"] = txtUsername.Text;
                    Session["Role"] = "User";
                }
                Response.Redirect("~/Pages/Landing/Default.aspx");
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