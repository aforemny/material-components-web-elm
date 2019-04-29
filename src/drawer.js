import createFocusTrap from "focus-trap";
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
        {},
        true /* shouldBubble */
      )),
      notifyOpen: () => this.dispatchEvent(new CustomEvent(
        strings.OPEN_EVENT,
        {},
        true /* shouldBubble */
      )),
      trapFocus: () => this.focusTrap.activate(),
      releaseFocus: () => this.focusTrap.deactivate(),
    };
  }

  constructor() {
    super();

    this.handleKeydown_ = this.handleKeydown.bind(this);
    this.handleTransitionEnd_ = this.handleTransitionEnd.bind(this);
    this.handleScrimClick_ = this.handleScrimClick.bind(this);
  }

  handleKeydown(event) {
    if (!this.mdcFoundation) return;
    const isEscape = event.key === 'Escape' || event.keyCode === 27;
    if (isEscape) {
      this.dispatchEvent(new CustomEvent(
        "MDCDrawer:close",
        {},
        true /* shouldBubble */
      ));
    }
  }

  handleTransitionEnd(event) {
    if (!this.mdcFoundation) return;
    this.mdcFoundation.handleTransitionEnd(event);
  }

  handleScrimClick(event) {
    if (!this.mdcFoundation) return;
    this.dispatchEvent(new CustomEvent(
      "MDCDrawer:close",
      {},
      true /* shouldBubble */
    ));
  }

  connectedCallback() {
    const { MODAL, DISMISSIBLE } = MDCDismissibleDrawerFoundation.cssClasses;
    if (this.classList.contains(DISMISSIBLE)) {
      this.mdcFoundation = new MDCDismissibleDrawerFoundation(this.adapter);
    } else if (this.classList.contains(MODAL)) {
      this.mdcFoundation = new MDCModalDrawerFoundation(this.adapter);
    }
    if (!this.mdcFoundation) return;

    this.mdcFoundation.init();
    if (this.hasAttribute("open")) {
      this.mdcFoundation.open();
    } else {
      this.mdcFoundation.close();
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
    if (!this.mdcFoundation) return;

    this.mdcFoundation.destroy();
    delete this.mdcFoundation;

    this.removeEventListener("keydown", this.handleKeydown_);
    this.removeEventListener("transitionend", this.handleTransitionEnd_);

    const { MODAL } = MDCDismissibleDrawerFoundation.cssClasses;
    if (this.classList.contains(MODAL)) {
      this.scrim.removeEventListener("click", this.handleScrimClick_);
      this.mdcFoundation.close();
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcFoundation) return;
    if (name === "open") {
      if (this.hasAttribute("open")) {
        this.mdcFoundation.open();
      } else {
        this.mdcFoundation.close();
      }
    }
  }
};

customElements.define("mdc-drawer", MdcDrawer);
