import { Component } from '@angular/core';
import { AuthService } from 'src/app/shared/services/auth.services';

@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  styleUrls: ['./forgot-password.component.scss']
})
export class ForgotPasswordComponent {
  constructor(
    public authService: AuthService
  ) { }
}
