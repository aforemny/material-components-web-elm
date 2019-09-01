import { getClassName, setClassName } from "./utils";
import { MDCIconButtonToggleFoundation } from "@material/icon-button/index";
import { MDCRipple } from "@material/ripple/index";

class MdcIconButton extends HTMLElement {

  static get observedAttributes() {
    return ["data-on"];
  }

  get adapter() {
    return {
      addClass: className => this.classList.add(className),
      removeClass: className => this.classList.remove(className),
      hasClass: className => this.classList.contains(className),
      setAttr: (attrName, attrValue) => this.setAttribute(attrName, attrValue),
      notifyChange: eventData => {
        const {CHANGE_EVENT} = MDCIconButtonToggleFoundation.strings;
        this.dispatchEvent(new CustomEvent(CHANGE_EVENT), { detail: eventData });
      },
    }
  }

  constructor() {
    super();
    this.className_ = "";
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  connectedCallback() {
    this.foundation_ = new MDCIconButtonToggleFoundation(this.adapter);
    this.foundation_.init();
    this.foundation_.toggle(this.hasAttribute("on"));
    this.ripple_ = new MDCRipple(this);
    this.ripple_.unbounded = true;
    this.addEventListener("click", this.handleClick);
  }

  handleClick(event) {
    event.stopPropagation();
    event.preventDefault();
    return false;
  }

  disconnectedCallback() {
    this.foundation_.destroy();
    this.ripple_.destroy();
    this.removeEventListener("click", this.handleClick);
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.foundation_) return;
    if (name === "data-on") {
      this.foundation_.handleClick.call(this.foundation_);
    }
  }
};

customElements.define("mdc-icon-button", MdcIconButton);
