import Component from "@ember/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { findAll } from "discourse/models/login-method";
import discourseComputed from "discourse-common/utils/decorators";

export default class CoupaSupplierLogin extends Component {
  @service router;

  @discourseComputed("router.currentRouteName")
  shouldDisplay(currentRouteName) {
    // check if currently on login page
    return currentRouteName === "login";
  }

  @discourseComputed
  buttons() {
    // get buttons
    return findAll();
  }

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
  }

  @action
  externalLogin(provider) {
    // add login action
    provider.doLogin({
      signup: true,
      params: {
        origin: window.location.href,
      },
    });
  }
}
