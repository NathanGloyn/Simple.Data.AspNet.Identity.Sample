using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using MVC5.Models;
using Simple.Data;
using Simple.Data.AspNet.Identity;

namespace MVC5.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminController : Controller {
        private ApplicationUserManager _userManager;
        private ApplicationRoleManager _roleManager;
        private readonly dynamic db;

        public AdminController() {
            db = Database.OpenNamedConnection("DefaultConnection");            
        }

        public AdminController(ApplicationUserManager userManager, ApplicationRoleManager roleManager):this() {
            UserManager = userManager;
            RoleManager = roleManager;
        }


        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }

        public ApplicationRoleManager RoleManager {
            get 
            {
                return _roleManager ?? HttpContext.GetOwinContext().Get<ApplicationRoleManager>();  
            }
            set 
            {
                _roleManager = value;
            }
        }

        public async Task<ActionResult> Index() {
            var users = db.AspNetUsers.All().Take(10).ToList<IdentityUser>();

            var userViewModels = new List<UserViewModel>();

            foreach (var user in users) {
                var viewModel = new UserViewModel(user);
 
                var roles = await UserManager.GetRolesAsync(viewModel.Id);
                foreach (var role in roles) {
                    viewModel.Role =  await RoleManager.FindByIdAsync(role);
                }
                userViewModels.Add(viewModel);
            }
            
             
            return View(userViewModels);
        }


        public ActionResult Create()
        {
            ViewBag.AvailableRoles = db.AspNetRoles.All().Select(db.AspNetRoles.Name).ToScalarList<string>();
            return View(new UserViewModel());
        }

        [HttpPost]
        public async Task<ActionResult> Create(UserViewModel userViewModel)
        {
            if (ModelState.IsValid) {
                var user = new ApplicationUser();
                user.Email = userViewModel.Email;
                user.UserName = userViewModel.UserName;

                await UserManager.CreateAsync(user);

                await UserManager.AddToRoleAsync(user.Id, userViewModel.SelectedRole);

                // Generate reset password token and email it to the user so that
                // they can set the password themselves
                //
                // string code = await UserManager.GeneratePasswordResetTokenAsync(user.Id);
                // var callbackUrl = Url.Action("ResetPassword", "Account", new { userId = user.Id, code = code }, protocol: Request.Url.Scheme);		
                // await UserManager.SendEmailAsync(user.Id, "Set Password", "An account has been created for you, please set your password by clicking <a href=\"" + callbackUrl + "\">here</a>");

                return RedirectToAction("Index");
            }

            return View(userViewModel);
        }

        public ActionResult Delete(string id) {
            var userProfile = new UserViewModel(UserManager.FindById(id));
            return View(userProfile);
        }

        [HttpPost, ActionName("Delete")]
        public  async Task<ActionResult> DeleteConfirmed(string id) {
            ApplicationUser user = await UserManager.FindByIdAsync(id);

            var result = await UserManager.DeleteAsync(user);

            if (result.Succeeded) {
                return RedirectToAction("Index");
            }
            AddErrors(result);
            return View();
        }

        public async Task<ActionResult> Unlock(string id) {
            
            
            var result = await UserManager.SetLockoutEndDateAsync(id, DateTimeOffset.Now.AddMinutes(-5));

            if (result.Succeeded)
            {
                result = await UserManager.ResetAccessFailedCountAsync(id);

                if (result.Succeeded)
                {
                    return RedirectToAction("Index");
                }
            }

            AddErrors(result);
            return RedirectToAction("Index");
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }
    }
}
