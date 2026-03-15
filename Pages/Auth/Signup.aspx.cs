using System;
using System.Collections.Generic;
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

        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtUsername.Text) &&
                !string.IsNullOrWhiteSpace(txtFirstName.Text) &&
                !string.IsNullOrWhiteSpace(txtLastName.Text) &&
                !string.IsNullOrWhiteSpace(txtAddress.Text) &&
                !string.IsNullOrWhiteSpace(txtPassword.Text) &&
                !string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                if (txtPassword.Text != txtConfirmPassword.Text)
                {
                    lblSignupMessage.Text = "Passwords do not match.";
                    return;
                }

                Session["User"] = txtUsername.Text;
                Response.Redirect("~/Pages/Landing/Default.aspx");
            }
        }
    }
}