import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';
import type { SelectedAnswers } from '../../types/quiz';

export default class QuizService extends Service {
  @tracked currentIndex = 0;
  @tracked showSubmit = false;
  @tracked isSubmitted = false;
  @tracked selectedAnswers: SelectedAnswers = {};

  reset(): void {
    this.currentIndex = 0;
    this.showSubmit = false;
    this.isSubmitted = false;
    this.selectedAnswers = {};
  }

  updateSelection(
    questionId: string,
    optionId: string,
    isChecked: boolean
  ): void {
    this.selectedAnswers[questionId] ??= [];
    let selections = this.selectedAnswers[questionId];
    if (isChecked) {
      if (!selections.includes(optionId)) {
        selections = [...selections, optionId];
      }
    } else {
      selections = selections.filter((id: string) => id !== optionId);
    }
    this.selectedAnswers = {
      ...this.selectedAnswers,
      [questionId]: selections,
    };
  }

  goToPrevious(): void {
    if (this.currentIndex > 0) {
      this.currentIndex--;
    }
  }

  goToNext(totalQuestions: number): void {
    if (this.currentIndex >= totalQuestions - 1) {
      this.showSubmit = true;
    } else {
      this.currentIndex++;
    }
  }

  submitQuiz(): void {
    this.isSubmitted = true;
  }
}

// Don't remove this declaration: this is what enables TypeScript to resolve
// this service using `Owner.lookup('service:quiz')`, as well
// as to check when you pass the service name as an argument to the decorator,
// like `@service('quiz') declare altName: QuizService;`.
declare module '@ember/service' {
  interface Registry {
    quiz: QuizService;
  }
}
