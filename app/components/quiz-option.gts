import type { TOC } from '@ember/component/template-only';
import type { QuizOption as QuizOptionType } from '../../types/quiz';

export interface QuizOptionSignature {
  Args: {
    option: QuizOptionType;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLLIElement;
}

const QuizOption = <template>
  <li
    class="flex items-start gap-3 p-3 border border-indigo-100 rounded-lg bg-indigo-50/30 hover:bg-indigo-50/50 transition-colors"
  >
    <div class="flex-1">
      <div class="text-gray-800 font-medium mb-1">
        {{@option.text}}
      </div>

      {{#if @option.image}}
        <img
          src={{@option.image}}
          alt={{@option.text}}
          class="mt-2 w-24 h-16 object-cover rounded"
        />
      {{/if}}

      {{#if @option.video}}
        <video
          src={{@option.video}}
          controls
          class="mt-2 w-24 h-16 object-cover rounded"
        >
          <track kind="captions" />
          Your browser does not support the video tag.
        </video>
      {{/if}}
    </div>
  </li>
</template> satisfies TOC<QuizOptionSignature>;

export default QuizOption;
