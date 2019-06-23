import { getClassName, setClassName } from "./utils";
import { getMatchesProperty } from "@material/ripple/util";
import { MDCChipFoundation } from "@material/chips/index";
import { MDCRipple, MDCRippleFoundation } from "@material/ripple/index";

const INTERACTION_EVENTS = [ "click", "keydown" ];

class MdcChip extends HTMLElement {

  static get observedAttributes() {
    return ["selected"];
  }

  constructor() {
    super();
    this.className_ = "";
    this.handleInteraction_ = this.handleInteraction.bind(this);
    this.handleTransitionEnd_ = this.handleTransitionEnd.bind(this);
    this.handleTrailingIconInteraction_ = this.handleTrailingIconInteraction.bind(this);
  }

  get className() {
    return getClassName.call(this);
  }

  set className(className) {
    setClassName.call(this, className);
  }

  get adapter() {
    return {
      addClass: className => this.classList.add(className),
      removeClass: className => this.classList.remove(className),
      hasClass: className => this.classList.contains(className),
      addClassToLeadingIcon: className => {
        if (this.querySelector(MDCChipFoundation.strings.LEADING_ICON_SELECTOR)) {
          this.querySelector(MDCChipFoundation.strings.LEADING_ICON_SELECTOR)
            .classList.add(className);
        }
      },
      removeClassFromLeadingIcon: className => {
        if (this.querySelector(MDCChipFoundation.strings.LEADING_ICON_SELECTOR)) {
          this.querySelector(MDCChipFoundation.strings.LEADING_ICON_SELECTOR)
            .classList.remove(className);
        }
      },
      eventTargetHasClass: (target, className) => target.classList.contains(className),
      notifyInteraction: () => {
        this.dispatchEvent(new CustomEvent(
          MDCChipFoundation.strings.INTERACTION_EVENT,
          {chipId: this.id},
          true /* shouldBubble */
        ))
      },
      notifySelection: selected => {
        this.dispatchEvent(new CustomEvent(
          MDCChipFoundation.strings.SELECTION_EVENT,
          {chipId: this.id, selected: selected},
          true /* shouldBubble */
        ))
      },
      notifyTrailingIconInteraction: () => {
        this.dispatchEvent(new CustomEvent(
          MDCChipFoundation.strings.TRAILING_ICON_INTERACTION_EVENT,
          {chipId: this.id},
          true /* shouldBubble */
        ))
      },
      notifyRemoval: () => {
        this.dispatchEvent(new CustomEvent(
          MDCChipFoundation.strings.REMOVAL_EVENT,
          {chipId: this.id, root: this},
          true /* shouldBubble */
        ))
      },
      getComputedStyleValue: propertyName =>
        window.getComputedStyle(this).getPropertyValue(propertyName),
      setStyleProperty: (propertyName, value) =>
        this.style.setProperty(propertyName, value)
    };
  }

  connectedCallback() {
    this.mdcFoundation = new MDCChipFoundation(this.adapter);
    this.mdcFoundation.init();
    this.mdcFoundation.setSelected(this.hasAttribute("selected"));

    this.initRipple();

    INTERACTION_EVENTS.forEach(evtType =>
      this.addEventListener(evtType, this.handleInteraction_)
    );
    this.addEventListener("transitionend", this.handleTransitionEnd_);

    if (this.querySelector(MDCChipFoundation.strings.TRAILING_ICON_SELECTOR)) {
      INTERACTION_EVENTS.forEach(evtType =>
      this.querySelector(MDCChipFoundation.strings.TRAILING_ICON_SELECTOR)
        .addEventListener(evtType, handleTrailingIconInteraction_)
      );
    }
  }

  handleInteraction(event) {
    this.mdcFoundation.handleInteraction(event);
  }

  handleTransitionEnd(event) {
    this.mdcFoundation.handleTransitionEnd(event);
  }

  handleTrailingIconInteraction(event) {
    this.mdcFoundation.handleTrailingIconInteraction(event);
  }

  initRipple() {
    const checkmarkEl = this.querySelector(MDCChipFoundation.strings.CHECKMARK_SELECTOR);
    if (checkmarkEl &&
      !this.querySelector(MDCChipFoundation.strings.LEADING_ICON_SELECTOR)) {
      const MATCHES = getMatchesProperty(HTMLElement.prototype);
      const adapter = Object.assign(MDCRipple.createAdapter(this), {
        isUnbounded: () => false,
        isSurfaceActive: this[MATCHES](":active"),
        addClass: className => this.classList.add(className),
        removeClass: className => this.classList.remove(className),
        containsEventTarget: target => this.contains(target),
        registerInteractionHandler: (type, handler) =>
          this.addEventListener(type, handler),
        deregisterInteractionHandler: (type, handler) =>
          this.removeEventListener(type, handler),
        updateCssVariable: (varName, value) =>
          this.style.setProperty(varName, value),
        computeBoundingRect: () => {
          const height = this.getBoundingClientRect().height;
          const width = this.getBoundingClientRect().width +
            checkmarkEl.getBoundingClientRect().height;
          return {height, width};
        }
      });
      this.mdcRipple = new MDCRipple(this, new MDCRippleFoundation(adapter));
    } else {
      this.mdcRipple = new MDCRipple(this);
    }
  }

  disconnectedCallback() {
    if (typeof this.mdcFoundation !== "undefined") {
      this.mdcFoundation.destroy();
      delete this.mdcFoundation;
    }

    if (typeof this.mdcRipple !== "undefined") {
      this.mdcRipple.destroy();
      delete this.mdcRipple;
    }

    INTERACTION_EVENTS.forEach(evtType =>
      this.removeEventListener(evtType, this.handleInteraction_)
    );
    this.removeEventListener("transitionend", this.handleTransitionEnd_);

    if (this.querySelector(MDCChipFoundation.strings.TRAILING_ICON_SELECTOR)) {
      INTERACTION_EVENTS.forEach(evtType =>
      this.querySelector(MDCChipFoundation.strings.TRAILING_ICON_SELECTOR)
        .removeEventListener(evtType, handleTrailingIconInteraction_)
      );
    }
  }

  attributeChangedCallback(name, oldValue, newValue) {
    if (!this.mdcFoundation) return;
    if (name === "selected") {
      this.mdcFoundation.setSelected(this.hasAttribute("selected"));
    }
  };
};

customElements.define("mdc-chip", MdcChip);
