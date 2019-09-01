import * as util from "@material/dialog/util";
import { closest, matches } from "@material/dom/ponyfill";
import createFocusTrap from "focus-trap";
import { getClassName, setClassName } from "./utils";
import { MDCDialogFoundation } from "@material/dialog/index";

class MdcDialog extends HTMLElement {

  static get observedAttributes() {
    return [ "open" ];
  }

  get adapter() {
    return {
      addClass: (className) => this.classList.add(className),
      removeClass: (className) => this.classList.remove(className),
      hasClass: (className) => this.classList.contains(className),
      addBodyClass: (className) => document.body.classList.add(className),
      removeBodyClass: (className) => document.body.classList.remove(className),
      eventTargetMatches: (target, selector) => matches(target, selector),
      trapFocus: () => this.focusTrap.activate(),
      releaseFocus: () => this.focusTrap.deactivate(),
      isContentScrollable: () => {
        const {CONTENT_SELECTOR} = MDCDialogFoundation.strings;
        const content = this.querySelector(CONTENT_SELECTOR);
        return !!content && util.isScrollable(content);
      },
      areButtonsStacked: () => {
        const {BUTTON_SELECTOR} = MDCDialogFoundation.strings;
        return util.areTopsMisaligned(
          [].slice.call(this.querySelectorAll(BUTTON_SELECTOR))
        );
      },
      getActionFromEvent: (event) => {
        const {ACTION_ATTRIBUTE} = MDCDialogFoundation.strings;
        const element = closest(event.target, `[${ACTION_ATTRIBUTE}]`);
        return element && element.getAttribute(ACTION_ATTRIBUTE);
      },
      clickDefaultButton: () => {
        const {DEFAULT_BUTTON_SELECTOR} = MDCDialogFoundation.strings;
        if (this.querySelector(DEFAULT_BUTTON_SELECTOR)) {
          this.querySelector(DEFAULT_BUTTON_SELECTOR).click();
        }
      },
      reverseButtons: () => {
        const {BUTTON_SELECTOR} = MDCDialogFoundation.strings;
        const buttons = [].slice.call(this.querySelectorAll(BUTTON_SELECTOR)).reverse();
        buttons.forEach(button => button.parentElement.appendChild(button));
      },
      notifyOpening: () => {
        const {OPENING_EVENT} = MDCDialogFoundation.strings;
        this.dispatchEvent(new CustomEvent(OPENING_EVENT));
      },
      notifyOpened: () => {
        const {OPENED_EVENT} = MDCDialogFoundation.strings;
        this.dispatchEvent(new CustomEvent(OPENED_EVENT));
      },
      notifyClosing: (action) => {
        const {CLOSING_EVENT} = MDCDialogFoundation.strings;
        this.dispatchEvent(new CustomEvent(CLOSING_EVENT, {
          detail: action ? {action} : {}
        }));
      },
      notifyClosed: (action) => {
        const {CLOSED_EVENT} = MDCDialogFoundation.strings;
        this.dispatchEvent(new CustomEvent(CLOSED_EVENT, {
          detail: action ? {action} : {}
        }));
      },
    }
  }

  constructor() {
    super();
    this.className_ = "";
    this.handleDocumentKeydown_ = this.handleDocumentKeydown.bind(this);
    this.handleInteraction_ = this.handleInteraction.bind(this);
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  connectedCallback() {
    this.foundation_ = new MDCDialogFoundation(this.adapter);
    this.foundation_.init();
    if (this.hasAttribute("open")) {
      this.foundation_.open();
    }

    this.foundation_.doClose = this.foundation_.close.bind(this.foundation_);
    this.foundation_.close = () => {
      this.dispatchEvent(new CustomEvent("MDCDialog:close"));
    };

    const { CONTAINER_SELECTOR } = MDCDialogFoundation.strings;
    this.focusTrap = util.createFocusTrapInstance(
      this.querySelector(CONTAINER_SELECTOR),
      createFocusTrap,
      null
    );

    const { OPENING_EVENT, CLOSING_EVENT } = MDCDialogFoundation.strings;
    this.addEventListener("click", this.handleInteraction_);
    this.addEventListener("keydown", this.handleInteraction_);
    this.addEventListener(OPENING_EVENT, this.handleOpening);
    this.addEventListener(CLOSING_EVENT, this.handleClosing);
  }

  handleInteraction(event) {
    this.foundation_.handleInteraction.call(this.foundation_, event);
  }

  handleOpening() {
    const LAYOUT_EVENTS = ["resize", "orientationchange"];
    LAYOUT_EVENTS.forEach(type => window.addEventListener(type, this.layout));
    document.addEventListener("keydown", this.handleDocumentKeydown_)
  }

  handleClosing() {
    const LAYOUT_EVENTS = ["resize", "orientationchange"];
    LAYOUT_EVENTS.forEach(type => window.removeEventListener(type, this.layout));
    document.removeEventListener("keydown", this.handleDocumentKeydown_)
  }

  handleDocumentKeydown(event) {
    this.foundation_.handleDocumentKeydown.call(this.foundation_, event);
  }

  layout() {
    this.foundation_.layout();
  }

  disconnectedCallback() {
    this.foundation_.destroy();

    const { OPENING_EVENT, CLOSING_EVENT } = MDCDialogFoundation.strings;
    this.removeEventListener("click", this.handleInteraction_);
    this.removeEventListener("keydown", this.handleInteraction_);
    this.removeEventListener(OPENING_EVENT, this.handleOpening);
    this.removeEventListener(CLOSING_EVENT, this.handleClosing);
    this.handleClosing();
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.foundation_) return;
    if (name === "open") {
      if (this.hasAttribute("open")) {
        this.foundation_.open();
      } else {
        this.foundation_.doClose();
      }
    }
  }
};

customElements.define("mdc-dialog", MdcDialog);
