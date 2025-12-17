import Component from '@glimmer/component';
import { service } from '@ember/service';
import { LinkTo } from '@ember/routing';
import Button from 'ember-latest/components/button';
import Submit from 'ember-latest/components/submit';
import Question from 'ember-latest/components/question';
import Navigation from 'ember-latest/components/navigation';
import type QuizService from 'ember-latest/services/quiz';
import type { QuizData, QuizQuestion } from '../../types/quiz';

interface QuizSignature {
  Args: {
    model: QuizData;
  };
}

export default class Quiz extends Component<QuizSignature> {
  @service declare quiz: QuizService;

  get currentQuestion(): QuizQuestion {
    return this.args.model.questions[this.quiz.currentIndex]!;
  }

  get totalQuestions(): number {
    return this.args.model.questions.length;
  }

  get isFirstQuestion(): boolean {
    return this.quiz.currentIndex === 0;
  }

  get isLastQuestion(): boolean {
    return this.quiz.currentIndex === this.totalQuestions - 1;
  }

  get currentSelectedOptions(): string[] {
    const questionId = this.currentQuestion.id;
    return this.quiz.selectedAnswers[questionId] ?? [];
  }

  get currentQuestionNumber(): number {
    return this.quiz.currentIndex + 1;
  }

  get hasCurrentSelection(): boolean {
    const selections = this.quiz.selectedAnswers[this.currentQuestion.id];
    return Array.isArray(selections) && selections.length > 0;
  }

  updateSelection = (
    questionId: string,
    optionId: string,
    isChecked: boolean
  ): void => {
    this.quiz.updateSelection(questionId, optionId, isChecked);
  };

  goToPrevious = (): void => {
    this.quiz.goToPrevious();
  };

  goToNext = (): void => {
    this.quiz.goToNext(this.totalQuestions);
  };

  submitQuiz = (): void => {
    this.quiz.submitQuiz();
  };

  restartQuiz = (): void => {
    this.quiz.reset();
  };

  <template>
    <main class="min-h-screen bg-slate-50 py-8" aria-label="Quiz">
      <div class="max-w-6xl mx-auto px-4">
        {{! Quiz Title Header }}
        <header class="mb-8">
          <h1 class="text-3xl font-bold text-center text-gray-800">
            {{@model.title}}
          </h1>
        </header>

        {{#if this.quiz.isSubmitted}}
          <div
            class="bg-white rounded-lg shadow-lg p-8 text-center"
            role="status"
            aria-live="polite"
            aria-atomic="true"
          >
            <div
              class="text-green-600 text-2xl font-semibold mb-4"
              role="alert"
            >
              <span aria-hidden="true">✓</span>
              Quiz submitted successfully!
            </div>
            <p class="text-gray-600 mb-6">Thank you for completing the quiz.</p>
            <div class="flex justify-center space-x-4">
              <Button
                @variant="primary"
                @size="lg"
                @onClick={{this.restartQuiz}}
              >
                Restart Quiz
              </Button>
              <LinkTo
                @route="index"
                class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded inline-block"
              >
                Go Home
              </LinkTo>
            </div>
          </div>
        {{else if this.quiz.showSubmit}}
          <Submit
            @quizData={{@model}}
            @selectedAnswers={{this.quiz.selectedAnswers}}
            @onSubmit={{this.submitQuiz}}
          />
        {{else}}
          {{! Main Quiz Content }}
          <div
            class="bg-white rounded-lg shadow-lg p-8"
            role="region"
            aria-label="Quiz question"
          >
            <Question
              @question={{this.currentQuestion}}
              @selectedOptions={{this.currentSelectedOptions}}
              @onUpdateSelection={{this.updateSelection}}
              @currentQuestionNumber={{this.currentQuestionNumber}}
              @totalQuestions={{this.totalQuestions}}
            />

            {{! Navigation Footer }}
            <div
              class="mt-8 pt-6 border-t border-gray-200 flex justify-between items-center"
            >
              <Navigation
                @isFirst={{this.isFirstQuestion}}
                @isLast={{this.isLastQuestion}}
                @hasSelection={{this.hasCurrentSelection}}
                @onPrevious={{this.goToPrevious}}
                @onNext={{this.goToNext}}
              />
            </div>
          </div>
        {{/if}}
      </div>
    </main>
  </template>
}

