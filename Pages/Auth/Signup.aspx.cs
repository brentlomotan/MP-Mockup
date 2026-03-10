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
            if (!string.IsNullOrWhiteSpace(txtSignupUsername.Text) && !string.IsNullOrWhiteSpace(txtSignupPassword.Text) && !string.IsNullOrWhiteSpace(txtConfirmPassword.Text))
            {
                if (txtSignupPassword.Text != txtConfirmPassword.Text)
                {
                    lblSignupMessage.Text = "Passwords do not match.";
                    lblSignupMessage.Visible = true;
                    return;
                }

                Session["User"] = txtSignupUsername.Text;
                Response.Redirect("~/Pages/Landing/Default.aspx");
            }
            else
            {
                lblSignupMessage.Text = "Please fill in all fields.";
                lblSignupMessage.Visible = true;
            }
        }
    }
}