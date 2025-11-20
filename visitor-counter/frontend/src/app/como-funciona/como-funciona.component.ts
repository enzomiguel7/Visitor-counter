import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-como-funciona',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './como-funciona.component.html',
  styleUrls: ['./como-funciona.component.css']
})
export class ComoFuncionaComponent implements OnInit {
  steps = [
    {
      number: '01',
      icon: 'sensors',
      title: 'Sensores Inteligentes',
      description: 'Sensores de alta precisão detectam a passagem de pessoas através de tecnologia avançada posicionada estrategicamente na entrada.',
      details: [
        'Detecção bidirecional (entrada e saída)',
        'Alcance de até 5 metros',
        'Precisão em diferentes condições',
        'Baixo consumo de energia'
      ]
    },
    {
      number: '02',
      icon: 'wifi',
      title: 'Transmissão de Dados',
      description: 'Os dados capturados são transmitidos instantaneamente para o servidor através de conexão segura.',
      details: [
        'Transmissão em tempo real',
        'Conexão Wi-Fi integrada',
        'Conexão segura',
        'Baixa latência de resposta'
      ]
    },
    {
      number: '03',
      icon: 'storage',
      title: 'Servidor e Processamento',
      description: 'O servidor recebe, processa e armazena os eventos de entrada e saída no banco de dados em tempo real.',
      details: [
        'API RESTful completa',
        'Processamento instantâneo',
        'Validação de dados',
        'Logs de auditoria'
      ]
    },
    {
      number: '04',
      icon: 'analytics',
      title: 'Armazenamento Seguro',
      description: 'Banco de dados MySQL armazena todo o histórico de eventos, permitindo análises detalhadas e geração de relatórios.',
      details: [
        'Armazenamento persistente',
        'Queries otimizadas',
        'Backup automático',
        'Escalabilidade'
      ]
    },
    {
      number: '05',
      icon: 'dashboard',
      title: 'Visualização em Tempo Real',
      description: 'A aplicação Angular exibe os dados instantaneamente com gráficos interativos e estatísticas atualizadas.',
      details: [
        'Atualização automática',
        'Gráficos interativos',
        'Design responsivo',
        'Interface intuitiva'
      ]
    }
  ];

  technicalSpecs = [
    {
      category: 'Software',
      icon: 'code',
      items: [
        { label: 'Backend', value: 'Node.js + Express' },
        { label: 'Frontend', value: 'Angular 18' },
        { label: 'Banco de Dados', value: 'MySQL 8.0' },
        { label: 'Protocolo', value: 'REST API' }
      ]
    }
  ];

  architecture = {
    layers: [
      {
        name: 'Camada Física',
        icon: 'sensors',
        components: ['Sensores Inteligentes', 'Sistema de Detecção', 'Alimentação']
      },
      {
        name: 'Camada de Comunicação',
        icon: 'cloud',
        components: ['Wi-Fi', 'Transmissão Segura', 'API REST']
      },
      {
        name: 'Camada de Aplicação',
        icon: 'layers',
        components: ['Node.js Server', 'MySQL', 'Processamento de Dados']
      },
      {
        name: 'Camada de Apresentação',
        icon: 'web',
        components: ['Angular App', 'Dashboard', 'Gráficos Interativos']
      }
    ]
  };

  ngOnInit(): void {
    window.scrollTo(0, 0);
  }
}
