import { Router } from '@angular/router';
import { Component, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-termos',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './termos.html',
  styleUrls: ['./termos.css']
})
export class TermosComponent {

  
    constructor( 
      private router: Router
    ) {}

  @Output() accepted = new EventEmitter<void>();
  @Output() closed = new EventEmitter<void>();

  accept() {
    this.accepted.emit();
  }

  close() {
    this.closed.emit();
  }
  redirectToRegister() {
    this.router.navigate(['/register']);
  }
}