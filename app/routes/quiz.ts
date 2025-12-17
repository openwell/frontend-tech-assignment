import Route from '@ember/routing/route';
import { service } from '@ember/service';
import type QuizService from 'ember-latest/services/quiz';
import type { QuizData } from '../../types/quiz';

export default class QuizRoute extends Route {
  @service declare quiz: QuizService;

  activate(): void {
    this.quiz.reset();
  }

  async model(): Promise<QuizData> {
    const response = await fetch('/api/quiz.json');
    const parsed = (await response.json()) as QuizData;
    return parsed;
  }
}
