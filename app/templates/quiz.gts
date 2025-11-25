import type { TOC } from '@ember/component/template-only';
import { pageTitle } from 'ember-page-title';

interface QuizSignature {
  Args: {
    model: unknown;
    controller: unknown;
  };
}

<template>{{pageTitle "Quiz"}}</template> satisfies TOC<QuizSignature>;
