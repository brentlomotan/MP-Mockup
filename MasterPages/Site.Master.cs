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
        }
    }
}