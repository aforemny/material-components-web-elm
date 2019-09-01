import createFocusTrap from "focus-trap";
import { getClassName, setClassName } from "./utils";
import { MDCDismissibleDrawerFoundation, MDCModalDrawerFoundation, util } from "@material/drawer/index";
import { MDCListFoundation } from "@material/list/index";
import { strings } from "@material/drawer/constants";

class MdcDrawer extends HTMLElement {

  static get observedAttributes() {
    return [ "open" ];
  }

  get adapter() {
    return {
      addClass: className => this.classList.add(className),
      removeClass: className => this.classList.remove(className),
      hasClass: className => this.classList.contains(className),
      elementHasClass: (element, className) => element.classList.contains(className),
      saveFocus: () => {
        this.previousFocus_ = document.activeElement;
      },
      restoreFocus: () => {
        const previousFocus = this.previousFocus_ && this.previousFocus_.focus;
        if (this.contains(document.activeElement) && previousFocus) {
          this.previousFocus_.focus();
        }
      },
      focusActiveNavigationItem: () => {
        const activeNavItemEl = this.querySelector(
          `.${MDCListFoundation.cssClasses.LIST_ITEM_ACTIVATED_CLASS}`
        );
        if (activeNavItemEl) {
          activeNavItemEl.focus();
        }
      },
      notifyClose: () => this.dispatchEvent(new CustomEvent(
        strings.CLOSE_EVENT,
        { bubbles: true }
      )),
      notifyOpen: () => this.dispatchEvent(new CustomEvent(
        strings.OPEN_EVENT,
        { bubbles: true }
      )),
      trapFocus: () => this.focusTrap.activate(),
      releaseFocus: () => this.focusTrap.deactivate(),
    };
  }

  constructor() {
    super();
    this.className_ = "";
    this.handleKeydown_ = this.handleKeydown.bind(this);
    this.handleTransitionEnd_ = this.handleTransitionEnd.bind(this);
    this.handleScrimClick_ = this.handleScrimClick.bind(this);
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  handleKeydown(event) {
    if (!this.foundation_) return;
    const isEscape = event.key === 'Escape' || event.keyCode === 27;
    if (isEscape) {
      this.dispatchEvent(new CustomEvent(
        "MDCDrawer:close",
        { bubbles: true }
      ));
    }
  }

  handleTransitionEnd(event) {
    if (!this.foundation_) return;
    this.foundation_.handleTransitionEnd(event);
  }

  handleScrimClick(event) {
    if (!this.foundation_) return;
    this.dispatchEvent(new CustomEvent(
      "MDCDrawer:close",
      { bubbles: true }
    ));
  }

  connectedCallback() {
    const { MODAL, DISMISSIBLE } = MDCDismissibleDrawerFoundation.cssClasses;
    if (this.classList.contains(DISMISSIBLE)) {
      this.foundation_ = new MDCDismissibleDrawerFoundation(this.adapter);
    } else if (this.classList.contains(MODAL)) {
      this.foundation_ = new MDCModalDrawerFoundation(this.adapter);
    }
    if (!this.foundation_) return;

    this.foundation_.init();
    if (this.hasAttribute("open")) {
      this.foundation_.open();
    } else {
      this.foundation_.close();
    }

    this.addEventListener("keydown", this.handleKeydown_);
    this.addEventListener("transitionend", this.handleTransitionEnd_);

    // Note: It seems Elm might initialize .mdc-drawer before .mdc-drawer-scrim
    // while applying DOM patches.
    window.requestAnimationFrame(() => {
      if (this.classList.contains(MODAL)) {
        this.focusTrap = util.createFocusTrapInstance(this, createFocusTrap);
        this.scrim.addEventListener("click", this.handleScrimClick_);
      }
    });
  }

  get scrim() {
    const { SCRIM_SELECTOR } = MDCDismissibleDrawerFoundation.strings;
    return this.parentElement.querySelector(SCRIM_SELECTOR);
  }

  disconnectedCallback() {
    this.removeEventListener("keydown", this.handleKeydown_);
    this.removeEventListener("transitionend", this.handleTransitionEnd_);

    const { MODAL } = MDCDismissibleDrawerFoundation.cssClasses;
    if (this.classList.contains(MODAL)) {
      this.scrim.removeEventListener("click", this.handleScrimClick_);
      this.foundation_.close();
    }

    this.foundation_.destroy();
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.foundation_) return;
    if (name === "open") {
      if (this.hasAttribute("open")) {
        this.foundation_.open();
      } else {
        this.foundation_.close();
      }
    }
  }
};

customElements.define("mdc-drawer", MdcDrawer);
