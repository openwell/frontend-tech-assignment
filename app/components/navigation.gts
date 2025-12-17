import Component from '@glimmer/component';
import Button from 'ember-latest/components/button';

export interface NavigationSignature {
  Args: {
    isFirst?: boolean;
    isLast?: boolean;
    hasSelection?: boolean;
    onPrevious?: () => void;
    onNext?: () => void;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

export default class Navigation extends Component<NavigationSignature> {
  get isDisabled(): boolean {
    return !this.args.hasSelection;
  }

  get isNextDisabled(): boolean {
    return Boolean(this.args.isLast) || this.isDisabled;
  }

  <template>
    <div class="flex justify-between items-center w-full relative">
      {{! Previous & Next Buttons (Left) }}
      <div class="flex gap-3">
        <Button
          @variant="secondary"
          @size="lg"
          @disabled={{@isFirst}}
          @onClick={{@onPrevious}}
          aria-label="Go to previous question"
        >
          &lt; Previous
        </Button>
        <Button
          @variant={{if this.isNextDisabled "muted" "secondary"}}
          @size="lg"
          @disabled={{this.isNextDisabled}}
          @onClick={{@onNext}}
          aria-label="Go to next question"
        >
          Next &gt;
        </Button>
      </div>

      {{! Action Button (Right) }}
      {{#if @isLast}}
        <Button
          @variant={{if @hasSelection "primary" "secondary"}}
          @size="xl"
          @disabled={{this.isDisabled}}
          @onClick={{@onNext}}
          aria-label="Review answers and submit quiz"
        >
          Review & Submit
        </Button>
      {{else}}
        <Button
          @variant={{if @hasSelection "primary" "secondary"}}
          @size="xl"
          @disabled={{this.isDisabled}}
          @onClick={{@onNext}}
          aria-label="Continue to next question"
        >
          Next Question
        </Button>
      {{/if}}
    </div>
  </template>
}
