/* eslint-disable ember/no-classic-components, ember/require-tagless-components */
import Component from "@ember/component";
import { action, computed } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import { findAll } from "discourse/models/login-method";

export default class CoupaSupplierLogin extends Component {
  @service router;

  @computed("router.currentRouteName")
  get shouldDisplay() {
    // check if currently on login page
    return this.router?.currentRouteName === "login";
  }

  @computed
  get buttons() {
    // get buttons
    return findAll();
  }

  @computed("buttons")
  get oidc() {
    // filter out oidc button
    let oidc;
    this.buttons.forEach(function (button) {
      if (button.name === "oidc") {
        oidc = button;
      }
    });
    return oidc;
  }

  @action
  externalLogin() {
    // add login action
    this.oidc.doLogin({
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
          @action={{this.externalLogin}}
          @translatedLabel={{this.oidc.title}}
          @icon="sign-in-alt"
          class="btn-primary"
        />
      {{/if}}
    {{/if}}
  </template>
}
