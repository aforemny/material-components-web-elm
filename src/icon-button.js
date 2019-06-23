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
      notifyChange: evtData => {
        const {CHANGE_EVENT} = MDCIconButtonToggleFoundation.strings;
        this.dispatchEvent(new CustomEvent(CHANGE_EVENT), evtData);
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
    this.mdcFoundation = new MDCIconButtonToggleFoundation(this.adapter);
    this.mdcFoundation.init();
    this.mdcFoundation.toggle(this.hasAttribute("on"));
    this.mdcRipple = new MDCRipple(this);
    this.mdcRipple.unbounded = true;
    this.addEventListener("click", this.handleClick);
  }

  handleClick(event) {
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
    this.removeEventListener("click", this.handleClick);
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcFoundation) return;
    if (name === "data-on") {
      this.mdcFoundation.handleClick.call(this.mdcFoundation);
    }
  }
};

customElements.define("mdc-icon-button", MdcIconButton);
