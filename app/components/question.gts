import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import type { QuizQuestion } from '../../types/quiz';

export interface QuestionSignature {
  Args: {
    question: QuizQuestion;
    selectedOptions: string[];
    onUpdateSelection: (
      questionId: string,
      optionId: string,
      isChecked: boolean
    ) => void;
    currentQuestionNumber: number;
    totalQuestions: number;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

export default class Question extends Component<QuestionSignature> {
  handleChange = (event: Event): void => {
    const target = event.target as HTMLInputElement | null;
    if (!target) {
      return;
    }

    const { checked, value } = target;
    this.args.onUpdateSelection(this.args.question.id, value, checked);
  };

  includes(array: string[] | undefined, value: string): boolean {
    return array?.includes(value) ?? false;
  }

  <template>
    {{! Section One }}
    <div class="mb-6 pb-4 border-b border-gray-200">
      <p
        class="text-sm font-medium text-indigo-600"
        role="status"
        aria-live="polite"
        aria-atomic="true"
      >
        <span class="sr-only">Progress: </span>
        Question
        {{@currentQuestionNumber}}
        of
        {{@totalQuestions}}
      </p>
    </div>

    <div
      class="flex flex-col lg:flex-row gap-8"
      role="group"
      aria-labelledby="question-text"
    >
      {{! Question Info Section (Left) }}
      <div class="flex-1">
        <div class="mb-4">
          <h2
            id="question-text"
            class="text-2xl font-semibold text-gray-800 mb-3"
          >
            {{@question.text}}
          </h2>
          {{#if @question.instructions}}
            <p
              id="question-instructions"
              class="text-gray-600 mb-4"
              role="note"
            >{{@question.instructions}}</p>
          {{/if}}
        </div>

        {{! Section Two  }}
        {{#if @question.image}}
          <div class="mb-4">
            <img
              src={{@question.image}}
              alt="Illustration for question: {{@question.text}}"
              class="w-full rounded-lg shadow-md"
            />
          </div>
        {{/if}}

        {{#if @question.video}}
          <div class="mb-4">
            <video
              src={{@question.video}}
              controls
              aria-label="Video content for question: {{@question.text}}"
              class="w-full rounded-lg shadow-md"
            >
              <track kind="captions" />
              Your browser does not support the video tag.
            </video>
          </div>
        {{/if}}
      </div>

      {{! Section Three  }}
      <div class="flex-1">
        <div class="mb-4">
          <h3
            id="options-heading"
            class="text-lg font-semibold text-gray-700 mb-4"
          >
            Answer Options (Select all that apply)
          </h3>
        </div>

        <div
          class="grid grid-cols-1 md:grid-cols-2 gap-4"
          role="group"
          aria-labelledby="options-heading"
          aria-describedby="question-instructions"
        >
          {{#each @question.options as |option|}}
            <label
              class="relative flex flex-col border-2 rounded-lg p-4 cursor-pointer transition-all
                {{if
                  (this.includes @selectedOptions option.id)
                  'border-indigo-500 bg-indigo-50 shadow-md'
                  'border-gray-200 hover:border-indigo-200 hover:shadow-sm'
                }}"
              aria-label="Option: {{option.text}}"
            >
              <div class="flex items-start mb-2">
                <input
                  type="checkbox"
                  id="option-{{@question.id}}-{{option.id}}"
                  value={{option.id}}
                  checked={{this.includes @selectedOptions option.id}}
                  {{on "change" this.handleChange}}
                  aria-checked={{this.includes @selectedOptions option.id}}
                  aria-describedby="option-text-{{@question.id}}-{{option.id}}"
                  class="mt-1 mr-3 w-5 h-5 text-indigo-600 border-gray-300 rounded focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                />
                <span
                  id="option-text-{{@question.id}}-{{option.id}}"
                  class="flex-1 text-gray-800 font-medium"
                >
                  {{option.text}}
                </span>
              </div>

              {{#if option.image}}
                <img
                  src={{option.image}}
                  alt="{{option.text}}"
                  class="w-full h-32 object-cover rounded mt-2"
                />
              {{/if}}

              {{#if option.video}}
                <div class="mt-2">
                  <video
                    src={{option.video}}
                    aria-label="Video for option: {{option.text}}"
                    class="w-full h-32 object-cover rounded"
                  >
                    <track kind="captions" />
                    Your browser does not support the video tag.
                  </video>
                </div>
              {{/if}}
            </label>
          {{/each}}
        </div>
      </div>
    </div>
  </template>
}
