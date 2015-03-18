using Microsoft.Owin;
using MVC5_Standard;
using Owin;

[assembly: OwinStartup(typeof(Startup))]
namespace MVC5_Standard
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
