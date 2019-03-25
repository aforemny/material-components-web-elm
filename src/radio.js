import { MDCRadioFoundation } from "@material/radio/index";

class MdcRadio extends HTMLElement {

  static get observedAttributes() {
    return ["checked", "disabled"];
  }

  get adapter() {
    return {
      setNativeControlDisabled: disabled => {
        this.querySelector("input").disabled = disabled;
      },
      addClass: className => {
        this.classList.add(className);
      },
      removeClass: className => {
        this.classList.remove(className);
      }
    };
  }

  constructor() {
    super();
  }

  connectedCallback() {
    this.mdcFoundation = new MDCRadioFoundation(this.adapter);
    this.mdcFoundation.init();
    this.mdcFoundation.setDisabled(this.hasAttribute("disabled"));
  }

  disconnectedCallback() {
    if (this.mdcFoundation) {
      this.mdcFoundation.destroy();
      delete this.mdcFoundation;
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcFoundation) return;
    if (name === "checked") {
      this.mdcFoundation.checked = newValue;
    } else if (name === "disabled") {
      this.mdcFoundation.disabled = newValue;
    }
  }
};

customElements.define("mdc-radio", MdcRadio);
