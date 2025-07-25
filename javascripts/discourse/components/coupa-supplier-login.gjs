import Component from "@ember/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import discourseComputed from "discourse/lib/decorators";
import { findAll } from "discourse/models/login-method";

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

  <template>
    {{#if this.shouldDisplay}}
      {{! check if correct route }}
      {{#if this.oidc}}
        {{! checks if oidc button exists }}
        <DButton
          @action={{action "externalLogin" this.oidc}}
          @translatedLabel={{this.oidc.title}}
          @icon="sign-in-alt"
          class="btn-primary"
        />
      {{/if}}
    {{/if}}
  </template>
}
