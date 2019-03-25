import { MDCSwitchFoundation } from "@material/switch/index";
import { MDCRipple, MDCRippleFoundation } from "@material/ripple/index";
import { getMatchesProperty } from "@material/ripple/util";

class MdcSwitch extends HTMLElement {

  static get observedAttributes() {
    return ["checked", "disabled"];
  }

  get adapter() {
    return {
      addClass: className => {
        this.classList.add(className);
      },
      removeClass: className => {
        this.classList.remove(className);
      },
      setNativeControlChecked: checked => {
        this.querySelector("input").checked = checked;
      },
      setNativeControlDisabled: disabled => {
        this.querySelector("input").disabled = disabled;
      }
    }
  }

  constructor() {
    super();
  }

  connectedCallback() {
    this.mdcFoundation = new MDCSwitchFoundation(this.adapter);
    this.mdcFoundation.init();
    this.mdcFoundation.setChecked(this.hasAttribute("checked"));
    this.mdcFoundation.setDisabled(this.hasAttribute("disabled"));
    this.initRipple();
    this.querySelector("input").addEventListener("click", this.handleChange);
  }

  initRipple() {
    const {RIPPLE_SURFACE_SELECTOR} = MDCSwitchFoundation.strings;
    const rippleSurface = this.querySelector(RIPPLE_SURFACE_SELECTOR);
    const MATCHES = getMatchesProperty(HTMLElement.prototype);
    const adapter = Object.assign(MDCRipple.createAdapter(this), {
      isUnbounded: () => true,
      isSurfaceActive: () =>
        this.querySelector("input")[MATCHES](':active'),
      addClass: (className) => rippleSurface.classList.add(className),
      removeClass: (className) => rippleSurface.classList.remove(className),
      registerInteractionHandler: (type, handler) =>
        this.querySelector("input").addEventListener(type, handler),
      deregisterInteractionHandler: (type, handler) =>
        this.querySelector("input").removeEventListener(type, handler),
      updateCssVariable: (varName, value) =>
        rippleSurface.style.setProperty(varName, value),
      computeBoundingRect: () => rippleSurface.getBoundingClientRect(),
    });
    const rippleFoundation = new MDCRippleFoundation(adapter);
    this.mdcRipple = new MDCRipple(this, rippleFoundation);
  }

  handleChange(event) {
    event.stopPropagation();
    event.preventDefault();
    return false;
  }

  disconnectedCallback() {
    if (this.mdcFoundation) {
      this.mdcFoundation.destroy();
      delete this.mdcFoundation;
    }
    if (this.mdcRipple) {
      this.mdcRipple.destroy();
      delete this.mdcRipple;
    }
    this.querySelector("input").removeEventListener("click", this.handleChange);
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcFoundation) return;
    if (name === "checked") {
      this.mdcFoundation.setChecked(this.hasAttribute("checked"));
    } else if (name === "disabled") {
      this.mdcFoundation.setDisabled(this.hasAttribute("checked"));
    }
  }
};

customElements.define("mdc-switch", MdcSwitch);
