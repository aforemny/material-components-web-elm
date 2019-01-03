import { MDCSnackbar } from "@material/snackbar/index";

class MdcSnackbar extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    this.MDCSnackbar = new MDCSnackbar(this);
  }

  disconnectedCallback() {
    if (typeof this.MDCSnackbar !== "undefined") {
      this.MDCSnackbar.destroy();
      delete this.MDCSnackbar;
    }
  }
};

customElements.define("mdc-snackbar", MdcSnackbar);
