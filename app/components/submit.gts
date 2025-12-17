import Component from '@glimmer/component';
import Button from 'ember-latest/components/button';
import QuizOption from 'ember-latest/components/quiz-option';
import type {
  QuizData,
  QuizOption as QuizOptionType,
  QuizQuestion,
  SelectedAnswers,
} from '../../types/quiz';

export interface SubmitSignature {
  Args: {
    quizData: QuizData;
    selectedAnswers: SelectedAnswers;
    onSubmit?: () => void;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

export default class Submit extends Component<SubmitSignature> {
  get questionsWithAnswers(): Array<
    QuizQuestion & {
      number: number;
      selectedOptions: QuizOptionType[];
      hasSelections: boolean;
      isCorrect: boolean;
    }
  > {
    return this.args.quizData.questions.map(
      (question: QuizQuestion, index: number) => ({
        ...question,
        number: index + 1,
        selectedOptions: this.getSelectedOptions(question),
        hasSelections: this.hasSelections(question.id),
        isCorrect: this.isCorrect(question),
      })
    );
  }

  getSelectedOptions(question: QuizQuestion): QuizOptionType[] {
    const selectedIds = this.args.selectedAnswers[question.id] ?? [];
    return selectedIds
      .map((id: string) =>
        question.options.find((opt: QuizOptionType) => opt.id === id)
      )
      .filter((opt): opt is QuizOptionType => Boolean(opt));
  }

  hasSelections(questionId: string): boolean {
    const selections = this.args.selectedAnswers[questionId];
    return Array.isArray(selections) && selections.length > 0;
  }

  isCorrect(question: QuizQuestion): boolean {
    const selectedIds = new Set(this.args.selectedAnswers[question.id] ?? []);
    const correct = new Set(question.correctOptionIds);
    if (selectedIds.size !== correct.size) {
      return false;
    }
    for (const id of correct) {
      if (!selectedIds.has(id)) {
        return false;
      }
    }
    return true;
  }

  get totalCorrect(): number {
    return this.questionsWithAnswers.filter((q) => q.isCorrect).length;
  }

  get totalQuestions(): number {
    return this.args.quizData.questions.length;
  }

  <template>
    <div class="bg-white rounded-lg shadow-lg p-8">
      <h2 class="text-2xl font-bold mb-6 text-gray-800">Review Your Answers</h2>

      <div
        class="flex flex-col md:flex-row md:items-center md:justify-between bg-indigo-50 border border-indigo-100 rounded-lg p-4 mb-6 gap-3"
      >
        <div class="text-lg font-semibold text-gray-800">
          Score:
          {{this.totalCorrect}}
          /
          {{this.totalQuestions}}
        </div>
        <div class="text-sm text-gray-600">
          Correct answers are marked below.
        </div>
      </div>

      <div class="space-y-6 mb-8">
        {{#each this.questionsWithAnswers as |question|}}
          <div class="border-b border-gray-200 pb-6 last:border-b-0">
            <div class="font-semibold text-lg text-gray-800 mb-3">
              Question
              {{question.number}}:
              {{question.text}}
            </div>

            <div
              class="mb-2 text-sm font-medium
                {{if question.isCorrect 'text-green-600' 'text-red-600'}}"
            >
              {{if question.isCorrect "Correct" "Incorrect"}}
            </div>

            <div class="ml-4">
              {{#if question.hasSelections}}
                <ul class="space-y-3">
                  {{#each question.selectedOptions as |option|}}
                    <QuizOption @option={{option}} />
                  {{/each}}
                </ul>
              {{else}}
                <p class="text-gray-500 italic">No selections made</p>
              {{/if}}
            </div>
          </div>
        {{/each}}
      </div>

      <div class="flex justify-end">
        <Button
          aria-label="Submit quiz answers"
          @size="xl"
          @variant="primary"
          @onClick={{@onSubmit}}
        >
          Submit Quiz
        </Button>
      </div>
    </div>
  </template>
}
