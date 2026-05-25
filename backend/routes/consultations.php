<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Consultations Routes
|--------------------------------------------------------------------------
|
| Here is where you can register consultations routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('consultations')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Consultations module API endpoints.'
        ]);
    });
});
