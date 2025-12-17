export interface QuizOption {
  id: string;
  text: string;
  image?: string;
  video?: string;
}

export interface QuizQuestion {
  id: string;
  text: string;
  instructions?: string;
  image?: string;
  video?: string;
  options: QuizOption[];
  correctOptionIds: string[];
}

export interface QuizData {
  title?: string;
  description?: string;
  questions: QuizQuestion[];
}

export type SelectedAnswers = Record<string, string[]>;

