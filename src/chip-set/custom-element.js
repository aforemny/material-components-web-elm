import { MDCChipSet } from "./component";

class MdcChipSet extends HTMLElement {

  focus() {
    let selectedChip = null;
    for (const chip of this.chipset_.chips) {
      if (chip.selected) {
        selectedChip = chip;
        break;
      }
    }

    if (!!selectedChip) {
      selectedChip.focusPrimaryAction();
    } else if (this.chipset_.chips.length > 0) {
      this.chipset_.chips[0].focusPrimaryAction();
    }
  }

  blur() {
    if (this.contains(document.activeElement)) document.activeElement.blur();
  }

  constructor() {
    super();
  }

  connectedCallback() {
    this.chipset_ = new MDCChipSet(this);
  }

  disconnectedCallback() {
    this.chipset_.destroy();
  }
};

customElements.define("mdc-chip-set", MdcChipSet);
