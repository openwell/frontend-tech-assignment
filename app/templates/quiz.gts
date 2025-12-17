import type { TOC } from '@ember/component/template-only';
import { pageTitle } from 'ember-page-title';
import Quiz from 'ember-latest/components/quiz';
import type { QuizData } from '../../types/quiz';

interface QuizSignature {
  Args: {
    model: QuizData;
    controller: unknown;
  };
}

<template>
  {{pageTitle "EmberQuickstart"}}

  <Quiz @model={{@model}} />
</template> satisfies TOC<QuizSignature>;
