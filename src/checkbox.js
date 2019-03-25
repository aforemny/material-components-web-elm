import { MDCCheckboxFoundation } from "@material/checkbox/index";

class MdcCheckbox extends HTMLElement {

  static get observedAttributes() {
    return [ "state", "disabled" ];
  }

  get adapter() {
    return {
      addClass: className => {
        this.classList.add(className);
      },
      removeClass: className => {
        this.classList.remove(className);
      },
      getNativeControl: () => {
        return this.querySelector("input");
      },
      forceLayout: () => {
        this.offsetWidth;
      },
      isAttachedToDOM: () => {
        return Boolean(this.parentNode);
      },
      isIndeterminate: () => {
        return this.getAttribute("state") === "indeterminate";
      },
      isChecked: () => {
        return this.getAttribute("state") === "checked";
      },
      hasNativeControl: () => {
        return true;
      },
      setNativeControlDisabled: disabled => {
        this.querySelector("input").disabled = disabled;
      },
    };
  }

  constructor() {
    super();
  }

  connectedCallback() {
    this.mdcFoundation = new MDCCheckboxFoundation(this.adapter);
    this.mdcFoundation.init();
    this.mdcFoundation.handleChange();
    this.mdcFoundation.setDisabled(this.hasAttribute("disabled"));

    const nativeControl = this.querySelector("input");
    nativeControl.addEventListener("click", this.handleChange);
    nativeControl.addEventListener("animationend", this.handleAnimationEnd);
  }

  handleChange(event) {
    event.stopPropagation();
    event.preventDefault();
    return false;
  }

  handleAnimationEnd(event) {
    if (!this.mdcFoundation) return;
    this.mdcFoundation.handleAnimationEnd();
  }

  disconnectedCallback() {
    if (this.mdcFoundation) {
      this.mdcFoundation.destroy();
      delete this.mdcFoundation;
    }
    const nativeControl = this.querySelector("input");
    nativeControl.removeEventListener("click", this.handleChange);
    nativeControl.removeEventListener("animationend", this.handleAnimationEnd);
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcFoundation) return;
    if (name === "state") {
        this.mdcFoundation.handleChange();
    } else if (name === "disabled") {
        this.mdcFoundation.setDisabled(this.hasAttribute("disabled"));
    }
  }
}

customElements.define("mdc-checkbox", MdcCheckbox);
