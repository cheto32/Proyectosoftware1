<body>
    <div class="container">
        <form method="POST" class="form-signin" action="<?php echo base_url();?>index.php/usuarios/validar_usuario">
            <h2 class="form-signin-heading">Iniciar Sesión</h2>
            <label for="inputRut" class="sr-only">RUT</label>
            <input type="text" name="input_rut" class="form-control" placeholder="Campo de RUT" required autofocus>
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" name="input_pass" class="form-control" placeholder="Password" required>
            <button class="btn btn-lg btn-primary btn-block" type="submit">LogIn</button>
        </form>
    </div>
</body>