# -*- coding: utf-8 -*-
import json

with open('app_pt.arb', 'r', encoding='utf-8') as f:
    pt = json.load(f)

new_translations = {
    # sprint
    "sprintAverageVelocity": "Velocity média",
    "sprintComplete": "Concluir Sprint",
    "sprintCompleteActiveFirst": "Conclua o sprint ativo primeiro",
    "sprintCreateFirst": "Crie o primeiro sprint",
    "sprintDays": "dias",
    "sprintDaysRemaining": "dias restantes",
    "sprintDuration": "Duração do sprint",
    "sprintEditTitle": "Editar Sprint",
    "sprintEndDateLabel": "Data fim",
    "sprintGoalHint": "Objetivo do sprint",
    "sprintGoalLabel": "Sprint Goal",
    "sprintNameHint": "Ex: Sprint 1",
    "sprintNameLabel": "Nome do sprint",
    "sprintNameRequired": "Nome do sprint obrigatório",
    "sprintNew": "Novo Sprint",
    "sprintNewTitle": "Novo Sprint",
    "sprintNoSprints": "Nenhum sprint",
    "sprintNumber": "Sprint {number}",
    "sprintPlanningBasedOnVelocity": "Baseado na velocity",
    "sprintPlanningCapacity": "Capacidade",
    "sprintPlanningConfirm": "Confirmar planning",
    "sprintPlanningDays": "dias",
    "sprintPlanningExceeded": "Capacidade excedida",
    "sprintPlanningNoStories": "Nenhuma story para planejar",
    "sprintPlanningNotEstimated": "Não estimada",
    "sprintPlanningSelected": "Selecionadas",
    "sprintPlanningSubtitle": "Selecione as stories para o sprint",
    "sprintPlanningSuggested": "Sugerido",
    "sprintPlanningTitle": "Sprint Planning",
    "sprintPointsCompleted": "Pontos concluídos",
    "sprintPointsPlanned": "Pontos planejados",
    "sprintStart": "Iniciar Sprint",
    "sprintStartButton": "Iniciar",
    "sprintStartDateLabel": "Data início",
    "sprintStoriesCount": "Stories",
    "sprintStoriesLabel": "Stories",
    "sprintTeamMembers": "Membros do time",
    "sprintTitle": "Sprint",
    "sprintVelocity": "Velocity",

    # state/status
    "stateSaving": "Salvando...",
    "statusActive": "Ativo",
    "statusCancelled": "Cancelado",
    "statusExpired": "Expirado",
    "statusOnline": "Online",
    "statusPastDue": "Atrasado",
    "statusPaused": "Pausado",
    "statusTrialing": "Em avaliação",

    # story
    "storyAdded": "Story adicionada",
    "storyDeleted": "Story excluída",
    "storyFormAcceptanceCriteriaSubtitle": "Defina os critérios para considerar a story como concluída",
    "storyFormAcceptanceCriteriaTitle": "Critérios de Aceitação",
    "storyFormAcceptanceTab": "Aceitação",
    "storyFormAddCriterionHint": "Adicionar critério de aceitação...",
    "storyFormDescriptionLabel": "Descrição",
    "storyFormDescriptionRequired": "Descrição obrigatória",
    "storyFormDetailsTab": "Detalhes",
    "storyFormEditTitle": "Editar Story",
    "storyFormEmptyDescription": "Nenhuma descrição",
    "storyFormIWantRequired": "Campo 'Eu quero' obrigatório",
    "storyFormNewTitle": "Nova Story",
    "storyFormOtherTab": "Outros",
    "storyFormSuggestions": "Sugestões",
    "storyFormTitleLabel": "Título",
    "storyFormTitleRequired": "Título obrigatório",
    "storyStatusPending": "Pendente",
    "storyStatusRevealed": "Revelada",
    "storyStatusVoting": "Em votação",

    # success
    "successCopied": "Copiado",
    "successDeleted": "Excluído",
    "successSaved": "Salvo",

    # theme
    "themeDarkMode": "Modo escuro",
    "themeLightMode": "Modo claro",

    # time
    "today": "Hoje",
    "tomorrow": "Amanhã",
    "yesterday": "Ontem",

    # tools
    "toolAgileProcess": "Agile Process",
    "toolAgileProcessDesc": "Gerencie projetos ágeis com Scrum, Kanban e Scrumban. Board, Backlog, Sprints e métricas integradas.",
    "toolAgileProcessDescShort": "Scrum, Kanban e metodologias ágeis",
    "toolEisenhower": "Matrice de Eisenhower",
    "toolEisenhowerDesc": "Priorize atividades por urgência e importância com votação colaborativa do time.",
    "toolEisenhowerDescShort": "Priorize por urgência e importância",
    "toolEstimation": "Estimation Room",
    "toolEstimationDesc": "Sessões de estimativa colaborativas com Planning Poker, T-Shirt sizing e outros métodos.",
    "toolEstimationDescShort": "Planning Poker e estimativas do time",
    "toolRetro": "Retrospectiva",
    "toolRetroDesc": "Conduza retrospectivas eficazes com templates prontos, votação e itens de ação.",
    "toolRetroDescShort": "Melhore continuamente com o time",
    "toolSmartTodo": "Smart Todo",
    "toolSmartTodoDesc": "Gerencie tarefas com board Kanban, CFD, métricas de fluxo e colaboração em tempo real.",
    "toolSmartTodoDescShort": "Board Kanban e gestão de tarefas",

    # validation/welcome
    "validationRequired": "Campo obrigatório",
    "welcomeBack": "Bem-vindo de volta",
    "yes": "Sim",
}

pt.update(new_translations)

with open('app_pt.arb', 'w', encoding='utf-8') as f:
    json.dump(pt, f, ensure_ascii=False, indent=2)

print(f"Added {len(new_translations)} translations. Total: {len(pt)}")
