import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SignInComponent } from './components/sign-in/sign-in.component';
import { SignUpComponent } from './components/sign-up/sign-up.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { ForgotPasswordComponent } from './components/forgot-password/forgot-password.component';
import { VerifyEmailComponent } from './components/verify-email/verify-email.component';
import { AddAgendamentoComponent } from './components/crud-agendamento/add-agendamento/add-agendamento.component';
import { AgendamentoListComponent } from './components/crud-agendamento/agendamento-list/agendamento-list.component';
import { EditAgendamentoComponent } from './components/crud-agendamento/edit-agendamento/edit-agendamento.component';
import { UnloggedGuard } from "./shared/guard/unlogged.guard.ts.guard"
import { LoggedGuard } from "./shared/guard/logged.guard.ts.guard"
import { AdmGuard } from "./shared/guard/adm.guard.ts.guard"
import { CommonModule } from '@angular/common';

const routes: Routes = [
  { path: '', redirectTo: '/sign-in', pathMatch: 'full' },
  { path: 'sign-in', component: SignInComponent, },
  { path: 'register-user', component: SignUpComponent },
  { path: 'dashboard', component: DashboardComponent, canActivate: [AdmGuard] },
  { path: 'forgot-password', component: ForgotPasswordComponent },
  { path: 'verify-email-address', component: VerifyEmailComponent },
  { path: 'register-agendamento', component: AddAgendamentoComponent },
  { path: 'view-agendamento', component: AgendamentoListComponent },
  { path: 'edit-agendamento/:id', component: EditAgendamentoComponent }
];
@NgModule({
  imports: [CommonModule, RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule { }