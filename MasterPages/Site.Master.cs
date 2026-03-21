using Antlr.Runtime.Tree;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP01_MP_Mockup
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = Request.Path.ToLower();

            if (path.Contains("default"))
            {
                HomeTab.Attributes["class"] += " active";
            }

            if (path.Contains("projects"))
            {
                ProjectsTab.Attributes["class"] += " active";
            }

            if (path.Contains("adminpanel"))
            {
                HomeTab.Attributes["class"] += " active";
            }

            if (path.Contains("analytics"))
            {
                ProjectsTab.Attributes["class"] += " active";
            }

            if (path.Contains("userdashboard") || path.Contains("bills") || path.Contains("transactions") || path.Contains("processtransaction"))
            {
                DashboardTab.Attributes["class"] += " active";
            }


            if (Session["User"] != null)
            {
                pnlLogin.Visible = false;
                pnlProfile.Visible = true;

                string username = Session["User"].ToString();
                lblUsername.Text = username;
                lblDropdownUsername.Text = username;

                string role = Session["Role"].ToString();

                if (role == "User")
                {
                    pnlUserLinks.Visible = true;
                    pnlDashboardTab.Visible = true;
                }

                if (role == "Admin")
                {
                    HomeTabText.InnerText = "Admin Dashboard";
                    HomeTab.HRef = "~/Pages/Admin/AdminPanel.aspx";
                    ProjectsTab.HRef = "~/Pages/Admin/FullAreaAnalytics.aspx";
                    ProjectsTabText.InnerText = "Full Area Analytics";
                }

                if (!IsPostBack)
                {
                    if (role == "Admin" && path.Contains("default"))
                        Response.Redirect("~/Pages/Admin/AdminPanel.aspx");
                    else if (role == "User" && path.Contains("default"))
                        Response.Redirect("~/Pages/Users/UserDashboard.aspx");
                }
                else
                {
                    pnlLogin.Visible = true;
                    pnlProfile.Visible = false;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Pages/Landing/Default.aspx");
        }

        protected void btnSettings_Click(object sender, EventArgs e)
        {
            if (Session["Role"] != null)
            {
                if (Session["Role"].ToString() == "Admin")
                {
                    Response.Redirect("~/Pages/Admin/AdminProfilePage.aspx");
                }
            }
        }
    }
}