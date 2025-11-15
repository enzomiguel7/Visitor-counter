import { Component, ViewEncapsulation, OnInit, HostListener, ElementRef, AfterViewInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  standalone: true,
  selector: 'app-home',
  imports: [CommonModule, RouterModule],
  templateUrl: './home.html',
  styleUrl: './home.css',
  encapsulation: ViewEncapsulation.None
})
export class HomeComponent implements OnInit, AfterViewInit {
  isHeaderScrolled = false;

  constructor(private elementRef: ElementRef) {}

  ngOnInit() {
    // Scroll suave configurado no styles.css global
  }

  ngAfterViewInit() {
    // Aguardar a renderização completa antes de configurar animações
    setTimeout(() => {
      this.setupScrollAnimations();
      this.setupDashboardPreviewAnimation();
    }, 100);
  }

  @HostListener('window:scroll', [])
  onWindowScroll() {
    // Scroll suave para header
    this.isHeaderScrolled = window.pageYOffset > 50;
  }

  setupScrollAnimations() {
    // Animação de entrada dos elementos ao scroll
    const observerOptions = {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const element = entry.target as HTMLElement;
          element.style.opacity = '1';
          element.style.transform = 'translateY(0)';
        }
      });
    }, observerOptions);

    // Elementos para animar
    const animateElements = this.elementRef.nativeElement.querySelectorAll('.stat-card, .feature-card, .step-card');
    animateElements.forEach((el: HTMLElement) => {
      el.style.opacity = '0';
      el.style.transform = 'translateY(30px)';
      el.style.transition = 'opacity 0.6s ease-out, transform 0.6s ease-out';
      observer.observe(el);
    });
  }

  setupDashboardPreviewAnimation() {
    // Animação especial para preview do dashboard
    const previewObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          // Anima o gráfico
          const chart = (entry.target as HTMLElement).querySelector('.preview-chart');
          if (chart) {
            chart.classList.add('visible');
          }
          
          // Anima os itens de features com delay
          const featureItems = (entry.target as HTMLElement).querySelectorAll('.preview-feature-item');
          featureItems.forEach((item, index) => {
            setTimeout(() => {
              item.classList.add('visible');
            }, index * 200);
          });
        }
      });
    }, {
      threshold: 0.2
    });

    const dashboardPreview = this.elementRef.nativeElement.querySelector('.dashboard-preview');
    if (dashboardPreview) {
      previewObserver.observe(dashboardPreview);
    }
  }
}
