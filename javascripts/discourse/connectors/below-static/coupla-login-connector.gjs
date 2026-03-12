/* eslint-disable ember/no-classic-components */
import Component from "@ember/component";
import { tagName } from "@ember-decorators/component";
import CoupaSupplierLogin from "../../components/coupa-supplier-login";

@tagName("")
export default class CouplaLoginConnector extends Component {
  <template><CoupaSupplierLogin /></template>
}
