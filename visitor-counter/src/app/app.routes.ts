import { Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { RegisterComponent } from './register/register.component';
import { LoginComponent } from './login/login.component';
import { DashboardComponent } from './content/content.component';
import { EventsComponent } from './events/events';
import { AuthGuard } from './auth-guard';

export const appRoutes: Routes = [
  { path: 'events', component: EventsComponent, canActivate: [AuthGuard]},
  { path: '', component: HomeComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'login', component: LoginComponent },
  { path: 'content', component: DashboardComponent, canActivate: [AuthGuard] },
];
