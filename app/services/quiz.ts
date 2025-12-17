import Service from '@ember/service';

export default class QuizService extends Service {}

// Don't remove this declaration: this is what enables TypeScript to resolve
// this service using `Owner.lookup('service:quiz')`, as well
// as to check when you pass the service name as an argument to the decorator,
// like `@service('quiz') declare altName: QuizService;`.
declare module '@ember/service' {
  interface Registry {
    'quiz': QuizService;
  }
}
