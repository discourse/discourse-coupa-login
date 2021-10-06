import Component from "@ember/component";
import discourseComputed from "discourse-common/utils/decorators";
import { inject as service } from "@ember/service";
import { findAll } from "discourse/models/login-method";

export default Component.extend({
  router: service(),

  @discourseComputed("router.currentRouteName")
  shouldDisplay(currentRouteName) {
    // check if currently on login page
    return currentRouteName == "login";
  },

  @discourseComputed
  buttons() {
    // get buttons
    return findAll();
  },

  @discourseComputed("buttons")
  oidc(buttons) {
    // filter out oidc button
    let oidc;
    buttons.forEach(function (button) {
      if (button.name === "oidc") {
        oidc = button;
      }
    });
    return oidc;
  },

  actions: {
    externalLogin(provider) {
      // add login action
      provider.doLogin({
        signup: true,
        params: {
          origin: window.location.href,
        },
      });
    },
  },
});
